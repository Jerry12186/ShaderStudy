Shader "MyShader/Chapter03/MyPhong"
{
	Properties
	{
		_MainTint("主颜色",Color) = (1,1,1,1)
		_MainTex("主贴图",2D) = "white"{}
		_SpecularColor("反射颜色",Color) = (1,1,1,1)
		_SpecPower("反射强度",Range(0, 30)) = 1
	}

	SubShader
	{
		Tags
		{
			"RenderType" = "Opaque"
		}
		LOD 200

		CGPROGRAM
		#pragma surface surf MyPhong
		fixed4 _MainTint;
		sampler2D _MainTex;
		fixed4 _SpecularColor;
		float _SpecPower;

		struct Input
		{
			float2 uv_MainTex;
		};
		//自定义光照模型
		fixed4 LightingMyPhong(SurfaceOutput s, fixed3 lightDir, half3 viewDir, fixed atten)
		{
			//反射
			float NdotL = dot(s.Normal, lightDir);
			float3 reflectionVector = normalize(2.0 * s.Normal * NdotL - lightDir);

			float spec = pow(max(0, dot(reflectionVector, viewDir)), _SpecPower);
			float3 finalSpec = _SpecularColor.rgb * spec;

			//最终效果
			fixed4 c;
			c.rgb = (s.Albedo * _LightColor0.rgb * max(0, NdotL)*atten) + (_LightColor0.rgb * finalSpec);
			c.a = s.Alpha;
			return c;
		}

		void surf(Input IN, inout SurfaceOutput o)
		{
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex);
		}

		ENDCG
		}
}

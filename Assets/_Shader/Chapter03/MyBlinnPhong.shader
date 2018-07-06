Shader "MyShader/Chapter03/MyBlinnPhong"
{
	Properties
	{
		_MainTint("主颜色",Color) = (1,1,1,1)
		_MainTex("主贴图",2D) = "white"{}
		_SpecularColor("反射颜色",Color) = (1,1,1,1)
		_SpecularPower("反射强度",Range(0.1, 60)) = 1
	}

	SubShader
	{
			Tags
		{
			"RenderType" = "Opaque"
		}
		LOD 200

		CGPROGRAM
		#pragma surface surf MyBlinnPhong
		fixed4 _MainTint;
		sampler2D _MainTex;
		fixed4 _SpecularColor;
		float _SpecularPower;

		struct Input
		{
			float2 uv_MainTex;
		};

		fixed4 LightingMyBlinnPhong(SurfaceOutput s, fixed3 lightDir, half3 viewDir, fixed atten)
		{
			float NdotL = max(0, dot(s.Normal, lightDir));
			float halfVector = normalize(lightDir + viewDir);
			float NdotH = max(0, dot(s.Normal, halfVector));
			float spec = pow(NdotH, _SpecularPower) * _SpecularColor;

			float4 c;
			c.rgb = (s.Albedo * _LightColor0.rgb*NdotL) + (_LightColor0.rgb*_SpecularColor.rgb*spec)*atten;
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

Shader "MyShader/Chapter03/MyCartoon" 
{
	Properties
	{
		_RampTex("梯度图",2D) = "white"{}
		_MainTex("主贴图",2D) = "white"{}
		_CelShadingLevel("卡通效果强度",Range(0,1)) = 0.5
	}

		SubShader
	{
		Tags
		{
			"RenderType" = "Opaque"
		}
		LOD 200

		CGPROGRAM
		#pragma surface surf MyCartoon
		
		sampler2D _RampTex;
		sampler2D _MainTex;

		struct Input
		{
			float2 uv_MainTex;
		};

		//自定义光照模型
		fixed4 LightingMyCartoon(SurfaceOutput s, fixed3 lightDir, half3 viewDir, fixed atten)
		{
			half NdotL = dot(s.Normal, lightDir);
			NdotL = tex2D(_RampTex, fixed2(NdotL, 0.5));
			fixed4 c;

			c.rgb = s.Albedo * _LightColor0.rgb * NdotL * atten;
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

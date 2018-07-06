Shader "MyShader/Chapter03/MyLambert"
{
	Properties
	{
		_MainTex("主贴图",2D) = "white"{}
	}

		SubShader
	{
		Tags
		{
			"RenderType" = "Opaque"
		}
		LOD 200

		CGPROGRAM
		#pragma surface surf MyLamert

		sampler2D _MainTex;

		struct Input
		{
			float2 uv_MainTex;
		};
		//自定义光照模型
		half4 LightingMyLamert(SurfaceOutput s, half3 lightDir, half atten)
		{
			half Ndot = dot(s.Normal, lightDir);
			half4 c;
			c.rgb = s.Albedo * _LightColor0.rgb * (Ndot * atten * 1);
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

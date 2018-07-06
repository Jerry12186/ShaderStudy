Shader "MyShader/Chapter02/Transparent" 
{
	Properties
	{
		_Color("反射颜色",Color) = (1,1,1,1)
		_MainTex("主贴图(RGB)",2D) = "white"{}
	}

		SubShader
	{
		Tags
		{
			"Queue" = "Transparent"
			"IgnoreProjector" = "True"
			"RenderType" = "Transparent"
		}
		LOD 200
		//剔除背面
		Cull Back

		CGPROGRAM
		#pragma surface surf Standard alpha:fade

		fixed4 _Color;
		sampler2D _MainTex;

		struct Input
		{
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			float4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}

		ENDCG
	}
}

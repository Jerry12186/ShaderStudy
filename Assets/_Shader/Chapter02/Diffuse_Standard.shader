Shader "MyShader/Chapter02/Diffuse_Standard" 
{
	Properties
	{
		_Color("颜色",Color) = (1,1,1,1)
		_Metallic("金属度",Range(0,1)) = 0.5
	}
	
	SubShader
	{
		Tags
		{
			"RenderType" = "Opaque"
		}
		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		struct Input
		{
			float2 uv_MainTex;
		};
		
		fixed4 _Color;
		half _Metallic;

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			o.Albedo = _Color.rgb;
			o.Metallic = _Metallic;
		}
		ENDCG
	}
		FallBack "Diffuse"
}

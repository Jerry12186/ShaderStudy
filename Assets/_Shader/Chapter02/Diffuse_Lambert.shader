Shader "MyShader/Chapter02/Diffuse_Lambert" 
{
	Properties
	{
		_Color("颜色",Color) = (1,1,1,1)
	}
	
	SubShader
	{
		Tags
		{
			"RenderType" = "Opaque"
		}
		CGPROGRAM
		//#pragma surface surf Standard fullforwardshadows
		#pragma surface surf Lambert fullforwardshadows
		#pragma target 3.0

		struct Input
		{
			float2 uv_MainTex;
		};
		
		fixed4 _Color;
		
		/*void surf(Input IN, inout SurfaceOutputStandard o)
		{
			o.Albedo = _Color.rgb;
		}*/
		void surf(Input IN, inout SurfaceOutput o)
		{
			o.Albedo = _Color.rgb;
		}
		ENDCG
	}
		FallBack "Diffuse"
}

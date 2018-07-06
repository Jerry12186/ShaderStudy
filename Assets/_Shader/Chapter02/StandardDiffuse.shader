Shader "MyShader/Chapter02/StandardDiffuse" 
{
	Properties
	{
		_Color("颜色",Color) = (1,1,1,1)
		_AmbientColor("边缘颜色",Color) = (1,1,1,1)
		_MySliderVaule("滑动条",Range(-10, 10)) = 2.5 
	}

	SubShader
	{
		Tags
		{
			"RenderType" = "Opaque"
		}
		LOD 200
		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		struct Input
		{
			float2 uv_MainTex;
		};
		
		fixed4 _Color;
		float4 _AmbientColor;
		float _MySliderVaule;
		
		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			fixed4 c = pow((_Color + _AmbientColor), _MySliderVaule);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
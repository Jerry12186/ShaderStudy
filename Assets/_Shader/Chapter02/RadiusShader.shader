Shader "Custom/RadiusShader" 
{
	Properties
	{
		_Center("中心点", Vector) = (0,0,0,0)
		_Radius("半径",Float) = 0.5
		_RadiusColor("半径颜色",Color) = (1,0,0,1)
		_RadiusWidth("半径宽度",Float) = 2
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
		#pragma surface surf Standard
		
		float3 _Center;
		float _Radius;
		fixed4 _RadiusColor;
		float _RadiusWidth;
		sampler2D _MainTex;
		
		struct Input
		{
			float2 uv_MainTex;
			float3 worldPos;
		};

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			float d = distance(_Center, IN.worldPos);
			
			if (d > _Radius && d < _Radius + _RadiusWidth)
				o.Albedo = _RadiusColor;
			else
				o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
		}
		ENDCG
	}
}
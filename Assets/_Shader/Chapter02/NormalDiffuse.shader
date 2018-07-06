Shader "MyShader/NormalDiffuse" 
{
	Properties
	{
		_MainTint("反射颜色",Color) = (1,1,1,1)
		_NormalTex("法线贴图",2D) = "bump"{}
		_NormalMapIntensity("法线强度",Range(0,3)) = 1
	}

	SubShader
	{
		Tags
		{
			"RenderType" = "Opaque"
		}
		LOD 200

		CGPROGRAM
		#pragma surface surf Lambert

		fixed4 _MainTint;
		sampler2D _NormalTex;
		float _NormalMapIntensity;

		struct Input
		{
			float2 uv_NormalTex;
		};

		void surf(Input IN, inout SurfaceOutput o)
		{
			float3 normalMap = UnpackNormal(tex2D(_NormalTex, IN.uv_NormalTex));
			fixed3 n = normalMap.rgb;
			n.x *= _NormalMapIntensity;
			n.y *= _NormalMapIntensity;

			o.Normal = normalize(n);
			o.Albedo = _MainTint.rgb;
			o.Alpha = _MainTint.a;
		}
 		ENDCG
	}
}

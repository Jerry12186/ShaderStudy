Shader "MyShader/Chapter02/Holographic" 
{
	Properties
	{
		_Color("反射颜色",Color) = (1,1,1,1)
		_MainTex("主贴图",2D) = "white"{}
		_DotProduct("边缘特效",Range(-1,1)) = 0.25
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
			CGPROGRAM
			#pragma surface surf Lambert alpha:fade nolighting

			fixed4 _Color;
			sampler2D _MainTex;
			float _DotProduct;

			struct Input
			{
				float2 uv_MainTex;
				float3 worldNormal;
				float3 viewDir;
			};

			void surf(Input IN, inout SurfaceOutput o)
			{
				float4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
				o.Albedo = c.rgb;

				float border = 1 - (abs(dot(IN.viewDir, IN.worldNormal)));
				float alpha = (border * (1 - _DotProduct) + _DotProduct);
				o.Alpha = c.a * alpha;
			}
			ENDCG
		}
}

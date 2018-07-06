Shader "MyShader/Chapter03/MyAnisoGraph" 
{
	Properties
	{
		_MainTint("主颜色", Color) = (1,1,1,1)
		_MainTex("主贴图", 2D) = "white"{}
		_SpecColor1("高光颜色", Color) = (1,1,1,1)
		_Specular("高光范围",Range(0,1)) = 0.5
		_SpecPower("高光强度",Range(0,1)) = 0.5
		_AnisoDir("各项异性方向",2D) = ""{}
		_AnisoOffset("偏移量", Range(-1,1)) = 0
	}

	SubShader
	{
		Tags
		{
			"RenderType" = "Opaque"
		}
		LOD 200
		
		CGPROGRAM
		#pragma surface surf MyAnisoGraph
		#pragma target 3.0

		fixed4 _MainTint;
		sampler2D _MainTex;
		fixed4 _SpecColor1;
		float _Specular;
		float _SpecPower;
		sampler2D _AnisoDir;
		float _AnisoOffset;

		struct Input
		{
			float2 uv_MainTex;
			float2 uv_AnisoDir;
		};
		struct SurfaceAnisoOutput
		{
			fixed3 Albedo;
			fixed3 Normal;
			fixed3 Emission;
			fixed3 AnisoDirection;
			half Specular;
			fixed Gloss;
			fixed Alpha;
		};
		
		fixed4 LightingMyAnisoGraph(SurfaceAnisoOutput s, fixed3 lightDir, half3 viewDir, fixed atten)
		{
			fixed3 halfVector = normalize(normalize(lightDir) + normalize(viewDir));
			float NdotL = saturate(dot(s.Normal, lightDir));
			fixed HdotA = dot(normalize(s.Normal + s.AnisoDirection), halfVector);
			float aniso = max(0, sin(radians((HdotA + _AnisoOffset) * 180)));
			float spec = saturate(pow(aniso, s.Gloss * 128)*s.Specular);

			fixed4 c;
			c.rgb = ((s.Albedo * _LightColor0.rgb * NdotL) + (_LightColor0.rgb * _SpecColor1.rgb * spec)) *atten;
			c.a = s.Alpha;

			return c;
		}

		void surf(Input IN, inout SurfaceAnisoOutput o)
		{
			half4 c = tex2D(_MainTex, IN.uv_MainTex) * _MainTint;
			float3 anisoTex = UnpackNormal(tex2D(_AnisoDir, IN.uv_AnisoDir));

			o.AnisoDirection = anisoTex;
			o.Specular = _Specular;
			o.Gloss = _SpecPower;
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}
}

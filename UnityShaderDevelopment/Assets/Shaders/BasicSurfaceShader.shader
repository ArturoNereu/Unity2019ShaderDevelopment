Shader "ShaderDemo/BasicSurfaceShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)

        _MainTex ("Albedo (RGB)", 2D) = "white" {}
		_BumpMap("Bumpmap", 2D) = "bump" {}
        _Metallic ("Metallic", Range(0,1)) = 0.0

		_Alpha("Transparency", Range(0,1)) = 1.0
    }
    SubShader
    {
		Tags {"Queue" = "Transparent" "IgnoreProjector" = "True" "RenderType" = "Transparent"}
        LOD 200

		Pass 
		{
			ZWrite On
			ColorMask 0
		}

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows alpha:fade
        #pragma target 3.0

		fixed4 _Color;
        sampler2D _MainTex;
		sampler2D _BumpMap;
		half _Metallic;

		float _Alpha;

        struct Input
        {
            float2 uv_MainTex;
			float2 uv_MaskTex;
			float2 uv_BumpMap;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;

            o.Albedo = c.rgb;
			o.Alpha = _Alpha;

			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));

            o.Metallic = _Metallic;
        }
        ENDCG
    }
    FallBack "Diffuse"
}

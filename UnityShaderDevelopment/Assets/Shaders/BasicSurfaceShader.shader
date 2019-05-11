Shader "Custom/BasicSurfaceShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}

		_BumpMap("Bumpmap", 2D) = "bump" {}

        _Glossiness ("Smoothness", Range(0,1)) = 0.5
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

        sampler2D _MainTex;
		sampler2D _BumpMap;

		float _Alpha;

        struct Input
        {
            float2 uv_MainTex;
			float2 uv_MaskTex;
			float2 uv_BumpMap;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;

        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;

            o.Albedo = c.rgb;
			o.Alpha = _Alpha;

			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));

            // Metallic and smoothness come from slider variables
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
        }
        ENDCG
    }
    FallBack "Diffuse"
}

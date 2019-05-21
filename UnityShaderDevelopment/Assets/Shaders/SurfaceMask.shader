Shader "ShaderDemo/SurfaceMask"
{
    Properties
	{
		[HDR]_MagicColor("Magic Color", Color) = (1,1,1,1)
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_Mask("Mask", 2D) = "white" {}
		_Normal("Normal Map", 2D) = "white" {}
		_Metallic("Metallic", 2D) = "white" {}
		_MagicMask("Magic Mask", float) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows

		fixed4 _MagicColor;

        sampler2D _MainTex;
		sampler2D _Mask;
		sampler2D _Normal;
		sampler2D _Metallic;

		float _MagicMask;

        struct Input
        {
            float2 uv_MainTex;
			float2 uv_BumpMap;
			float2 uv_MetallicMap;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);

			float isMask = tex2D(_Mask, IN.uv_MainTex).xyz == fixed3(1,1,1) && _MagicMask == 1;

			o.Albedo = ((1 - isMask) * c.rgb) + (isMask * _MagicColor);

			o.Normal = UnpackNormal(tex2D(_Normal, IN.uv_BumpMap));

			fixed4 metal = tex2D(_Metallic, IN.uv_MetallicMap);
			o.Metallic = metal.r;
			o.Smoothness = metal.g;
			            
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}

Shader "Custom/PostProcessingBlur"
{
	HLSLINCLUDE
	#include "Packages/com.unity.postprocessing/PostProcessing/Shaders/StdLib.hlsl"

	TEXTURE2D_SAMPLER2D(_MainTex, sampler_MainTex);
	float _blurSize;

	float4 Frag(VaryingsDefault i) : SV_Target
	{
		float4 color = 0;

		for (float index = 0; index < 10; index++)
		{
			float2 uv = i.texcoord + float2(0, index / 9.0 - 0.5) * _blurSize;

			color += SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, uv);
		}
		color = color / 10;
		return color;
	}

	ENDHLSL

	SubShader
	{
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			HLSLPROGRAM

			#pragma vertex VertDefault
			#pragma fragment Frag

			ENDHLSL
		}
	}
}
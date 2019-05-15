Shader "ShaderDemo/BasicTextureBlend"
{
	Properties
	{
		_MainTex("Main Texture", 2D) = "white" {}
		_SecondTex("Secondary Texture", 2D) = "white" {}
		_TexInfluence("Texture Influence", Range(0,1)) = 1
	}

	SubShader
	{
		pass
		{
			Tags { "RenderType" = "Opaque" }

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			sampler2D _MainTex;
			sampler2D _SecondTex;
			float _TexInfluence;

			struct v2f
			{
				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			v2f vert(appdata_base v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.uv = v.texcoord.xy;
				return o;
			}

			fixed4 frag(v2f i) : COLOR
			{
				return lerp(tex2D(_MainTex, i.uv), tex2D(_SecondTex, i.uv), _TexInfluence);
			}
			ENDCG
		}
    }
    FallBack "Diffuse"
}

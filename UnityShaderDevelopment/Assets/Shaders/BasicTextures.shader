Shader "Custom/BasicTextures"
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,1)
		_Albedo("Albedo", 2D) = "white" {}
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

			fixed4 _Color;
			sampler2D _Albedo;

			struct v2f
			{
				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD1;
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
				return _Color * tex2D(_Albedo, i.uv);
			}

			ENDCG
		}
    }
    FallBack "Diffuse"
}

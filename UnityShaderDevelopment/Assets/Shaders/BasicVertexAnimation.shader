Shader "ShaderDemo/BasicVertexAnimation"
{
	Properties
	{
		_Albedo("Albedo", 2D) = "white" {}
		_RotationValue("RotationValue", float) = 0
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

			sampler2D _Albedo;
			float _RotationValue;

			struct v2f
			{
				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD1;
			};

			inline float3x3 yRotation3dRadians(float rad) 
			{
				float s = sin(rad);
				float c = cos(rad);
				return float3x3(
					c, 0, -s,
					0, 1, 0,
					s, 0, c);
			}

			v2f vert(appdata_base v)
			{
				v2f o;

				v.vertex = float4(mul(yRotation3dRadians(radians(_RotationValue * _Time.y) + v.vertex.y), v.vertex), 1);

				o.pos = UnityObjectToClipPos(v.vertex);

				o.uv = v.texcoord.xy;
				return o;
			}

			fixed4 frag(v2f i) : COLOR
			{
				return tex2D(_Albedo, i.uv);
			}

			ENDCG
		}
    }
    FallBack "Diffuse"
}

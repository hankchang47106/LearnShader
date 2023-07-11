Shader "Custom/TestLoading"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Speed ("Speed", float) = 100
    }
    SubShader
    {
        // No culling or depth
        //Cull Off ZWrite Off ZTest Always

        Blend SrcAlpha OneMinusSrcAlpha

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;
            float _Speed;

            fixed4 frag(v2f i) : SV_Target
            {
                float2 tmpUV = i.uv;

                // 1. ��������I
                tmpUV -= float2(0.5, 0.5);

                // �L�o�﨤�u�Z���W�L0.5���I
                if (length(tmpUV) > 0.5)
                {
                    return fixed4(0, 0, 0, 0);
                }

                float2 finalUV = 0;

                // �ɶ��b
                float angle = _Time.x * _Speed;

                // 2. ����
                finalUV.x = tmpUV.x * cos(angle) - tmpUV.y * sin(angle);
                finalUV.y = tmpUV.x * sin(angle) + tmpUV.y * cos(angle);

                // 3. ��������m
                finalUV += float2(0.5, 0.5);

                fixed4 col = tex2D(_MainTex, finalUV);
                // just invert the colors
                //col.rgb = 1 - col.rgb;
                return col;
            }
            ENDCG
        }
    }
}

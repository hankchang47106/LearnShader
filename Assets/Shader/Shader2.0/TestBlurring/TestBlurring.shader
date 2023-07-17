Shader "Custom/TestBlurring"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Ambient("Ambient", float) = 0.001
    }
    SubShader
    {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always

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
            float _Ambient;

            fixed4 frag(v2f i) : SV_Target
            {
                float2 tmpUV = i.uv;

                fixed4 co1 = tex2D(_MainTex, tmpUV);
                fixed4 co2 = tex2D(_MainTex, tmpUV + float2(-_Ambient, 0));
                fixed4 co3 = tex2D(_MainTex, tmpUV + float2(0, -_Ambient));
                fixed4 co4 = tex2D(_MainTex, tmpUV + float2(_Ambient, 0));
                fixed4 co5 = tex2D(_MainTex, tmpUV + float2(0, _Ambient));

                fixed4 co = (co1 + co2 + co3 + co4 + co5) / 5.0;

                return co;
            }
            ENDCG
        }
    }
}

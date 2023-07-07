Shader "Custom/SetTexture"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        // _BlendTex("BlendTex", 2D) = "white" {}
        _TestColor("TestColor", Color) = (1, 1, 1, 1)
    }
    SubShader
    {
        Pass {
             
            //Color[_TestColor]

            // 格式：SetTexture [TextureName] {Texture Block}
            // TextureName：紋理變數

            /*
            SetTexture[_MainTex] {
                // combine Primary * Texture
                combine Primary + Texture
            }
            */
            /*
            SetTexture[_MainTex] {
                combine Texture
            }
            */
            /*
            SetTexture[_BlendTex] {
                combine Previous * Texture
            }
            */

            /*
            SetTexture[_BlendTex] {
                combine Previous lerp(Previous) Texture
            }
            */

            SetTexture[_MainTex] {
                //constantColor(1, 0, 0, 1)
                constantColor[_TestColor]
                combine Texture * Constant
            }
        }
    }
}
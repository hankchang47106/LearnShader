Shader "Custom/TestVertexShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}

        _TestColor ("TestColor", Color) = (0,1,0,1)
        _TestDiffuseColor("TestDiffuseColor", Color) = (1,1,1,1)
        _TestAmbientColor("TestAmbientColor", Color) = (1,1,1,1)
        _TestSpecularColor("TestSpecularColor", Color) = (1,1,1,1)
        _TestEmissionColor("TestEmissionColor", Color) = (1,1,1,1)
    }
    SubShader
    {
        Pass
        {
            // 改變頂點的顏色
            //Color(1, 0, 0, 1)  // 直接設定顏色
            Color [_TestColor]  // 使用變數

            Material {
                Diffuse [_TestDiffuseColor]    // 材質的漫反射

                Ambient [_TestAmbientColor]
                
                Specular[_TestSpecularColor]

                Emission[_TestEmissionColor]

            }

            Lighting On             // Off，燈光的總開關
            SeparateSpecular On     // Off，當為On時Material中的Specular顏色才有作用
        }
    }
}

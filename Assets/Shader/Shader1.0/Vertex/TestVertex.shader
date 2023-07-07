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
            // ���ܳ��I���C��
            //Color(1, 0, 0, 1)  // �����]�w�C��
            Color [_TestColor]  // �ϥ��ܼ�

            Material {
                Diffuse [_TestDiffuseColor]    // ���誺���Ϯg

                Ambient [_TestAmbientColor]
                
                Specular[_TestSpecularColor]

                Emission[_TestEmissionColor]

            }

            Lighting On             // Off�A�O�����`�}��
            SeparateSpecular On     // Off�A��On��Material����Specular�C��~���@��
        }
    }
}

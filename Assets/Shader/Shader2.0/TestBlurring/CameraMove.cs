using UnityEngine;

public class CameraMove : MonoBehaviour
{
    public Material material;

    private void OnRenderImage(RenderTexture sourceTexture, RenderTexture destinationTexture)
    {
        Graphics.Blit(sourceTexture, destinationTexture, material);
    }
}

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DioaramaPostProcessing : MonoBehaviour
{
    public Material postProcessingMaterial;

    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        Graphics.Blit(source, destination, postProcessingMaterial);
    }
}

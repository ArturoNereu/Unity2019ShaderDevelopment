using System;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

[Serializable]
[PostProcess(typeof(DioramaPostProcessingRenderer), PostProcessEvent.AfterStack, "Custom/PostProcessingBlur")]
public sealed class DioramaPostProcessing : PostProcessEffectSettings
{
    [Range(0f, .1f), Tooltip("Grayscale effect intensity.")]
    public FloatParameter blurSize = new FloatParameter { value = 0.05f };
}

public sealed class DioramaPostProcessingRenderer : PostProcessEffectRenderer<DioramaPostProcessing>
{
    public override void Render(PostProcessRenderContext context)
    {
        var sheet = context.propertySheets.Get(Shader.Find("Custom/PostProcessingBlur"));
        sheet.properties.SetFloat("_blurSize", settings.blurSize);
        context.command.BlitFullscreenTriangle(context.source, context.destination, sheet, 0);
    }
}
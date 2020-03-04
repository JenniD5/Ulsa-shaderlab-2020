shader "Custom/SDRimlight"
{
    Properties
    {                                  //rojo
        [HDR]_RimColor ("Rim Color", Color)=(1,0,0,1)
        _Rimpower("Rim Power", Range (0.0,8.0))=1.0

    }

    SubShader
    {
     Tags
     {
         "Queve"="Geometry"
          "RenderType"="Opaque"
     }

    CGPROGRAM
      #pragma surface surf Lambert 
      half3 _RimColor;
      float _Rimpower;
      struct Input 
     {
         float3 viewDir; //viewdirection

     };

     void surf(Input IN, inout SurfaceOutput o)
     {
      float3 nVD=normalize(IN.viewDir);
      float3 NdotV = dot(nVD, o.Normal);
      half rim= 1 - saturate(NdotV); //para que lo use de la manera correcta 
      o.Emission = _RimColor.rgb * pow(rim, _Rimpower); //pow ...eleva al cuadrado 
      
        
     }

    ENDCG

    }

}

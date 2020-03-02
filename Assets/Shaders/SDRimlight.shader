shader "Custom/SDRimlight"
{
    Properties
    {                                  //rojo
        [HDR]_RimColor ("Rim Color", Color)=(1,0,0,1)

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
      struct Input 
     {
         float3 viewDir; //viewdirection

     };

     void surf(Input IN, inout SurfaceOutput o)
     {
      float3 nVD=normalize(IN.viewDir);
      float3 NdotV = dot(nVD, o.Normal);
      half rim= 1 - NdotV;
      o.Emission = _RimColor.rgb * rim; 

        
     }

    ENDCG

    }

}
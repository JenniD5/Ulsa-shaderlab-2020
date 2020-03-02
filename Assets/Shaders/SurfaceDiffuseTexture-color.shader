shader "Custom/SurfaceDiffuseTexture-color"
{
    Properties
    {
      _MainTex ("Main Texture",2D)="white"{}
        
      
    }
    Subshader
    {
    Tags
    {
      "Queve"="Geometry"
    }

    CGPROGRAM
     #pragma surface surf Lambert
     sampler2D _MainTex;

     struct Input
     {
     float2 uv_MainTex;
     };

     void surf (Input IN, inout SurfaceOutput o)
     {
         half4 texColor= tex2D (_MainTex, IN.uv_MainTex);
         o.Albedo=texColor.rgb;
     }

    ENDCG
    }
}
shader "phong/Custom"
{
    Properties
    {
         _Albedo ("Albedo Color", Color) = (1,1,1,1)
         _SpecularColor ("Specuar Color", Color)= ( 1,0,0,1)
         _SpecularGloss("Specular Gloss", Range(1, 5))=1
         _GlossStep("Gloss Step", Range (1,8))=4
         _SpecularPower("Specuar Power", Range (1.0, 10.0))=5.0


    }

    SubShader
    {
        Tags
        {
           "Queve"="Geometry"
           "RenderType"="Opaque"
        }


        CGPROGRAM
        
        #pragma Surface surf Phong
        half4 _Albedo;
        half4 _GlossStep;
        int _SpecularColor;
        int _GlossStep;
        half _SpecularPower; 

        half4 LightingPhong (SurfaceOutput s, half3 viewDir, half3 lightDir, half atten)
        {
            half Ndot = dot(s.Normal * lightDir);
            half3 reflectedLight = reflect (-lightDir,s.Normal);
            half RdotV = dot (reflectedLight, viewDir);
            half specularity = pow(RdotV,_SpecularColor/_GlossStep)*_SpecularPower *_SpecularColor;

            
            half4 c;
            c.rgb = (Albedo * Ndot + specularity) *_LightColor0.rgb * atten; 
            c.a=s.Alpha;
            return c; 
        }

         struct InputPatch
          {
             float a;
          };

          void surf (Input In, inout SurfaceOutput o)
          {
              o.Albedo= _Albedo.rgb; 
          }
        ENDCG
    }
}

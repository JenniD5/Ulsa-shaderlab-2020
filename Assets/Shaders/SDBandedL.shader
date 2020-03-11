shader "Custom/SDBandedL"
{
    Properties
    {
         _Albedo("Albedo Color",Color)=(1,1,1,1)
        _Steps("Light Steps",Range(0.0,100))=20.0
    }

    SubShader
    {

        Tags
        {
            "Queve"="Geometry"
            "RenderType"="Opaque"
        }

        CGPROGRAM
        #pragma surface surf Banded
        
        half4 _Albedo;
        half _Steps;
        int _Buffer=256;

        half4 LightingBanded(SurfaceOutput s, half3 LightDir, half atten)
        {
           half NdotL= max (0, dot(s.Normal, LightDir));  
           half LightBandsMultiplier =_Steps/_Buffer;
           half LightBandsAdditive=_Steps/2;
           fixed bandedDiff = floor((NdotL*256 + LightBandsAdditive) /_Steps)*LightBandsMultiplier;

           half4 c;
           c.rgb = bandedDiff * s.Albedo* _LightColor0.rgb * atten; 
           c.a = s.Alpha;
           return c; 

        }

        struct Input 
        {
               float a;
        };

        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo=_Albedo.rgb;
        }


        ENDCG
    }
}
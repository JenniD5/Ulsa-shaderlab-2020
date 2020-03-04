shader "Custom/SDCustomWrap"
{
    Properties
    {
         _Albedo("Albedo Color", Color)=(1,1,1,1)
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
    
    half4 LightingLambertWrap (SurfaceOutput s, half3 lightDir, half atten)
    {
        half Ndot = dot(s.Normal, lightDir);
        half diff = Ndot * 0.5 + 0.5;
        half4 c;
        c.rgb = s.Albedo * _LightColor0.rgb * (diff * atten);
        c.a =s.Alpha; 
        return c;

    }

    half4 _Albedo;

    struct Input
    {
    float2 uv_MainTex;
    };
    void surf(Input IN, inout SurfaceOutput o)
    {
        o.Albedo =_Albedo.rgb;
    } 
    ENDCG
    }

}
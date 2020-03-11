shader "Custom/SDAct"
{
    Properties 
    {
     _MainTex ("Main Texture",2D)="white"{}
                        //para el normal map 
     _NormalTex("Normal Texture", 2D)="bump"{}

     _Albedo("Albedo Color",Color)=(1,1,1,1)

     [HDR]_RimColor("Rim Color", Color)=(1,0,0,1)

     _RimPower("Rim Power", Range(0.0,8.0))=1.0

     _RampTex("Ramp Texture", 2D)="white"{}
 
    


    }

    Subshader
    {
        Tags
        {
            "Queve"="Geometry"
            "RenderType"="Opaque"
        }

        CGPROGRAM
          #pragma surface surf Ramp 

          half4 _Albedo;
           
         sampler2D _RampTex;
          half _RimPower;

          half3 _RimColor;
          sampler2D _MainTex;
          sampler2D _NormalTex;
           
           half4 LightingRamp(SurfaceOutput s, half3 lightDir, half atten)
           {
               half Ndot = dot(s.Normal, lightDir);
               half diff= Ndot *0.5 + 0.5;
               float2 uv_RampTex=float2(diff, 0);
               half3 rampColor=tex2D(_RampTex, uv_RampTex).rgb;
               half4 c;
               c.rgb=s.Albedo * _LightColor0.rgb *rampColor *atten;
               c.a=s.Alpha;
               return c; 
           }




          struct Input
          {
          float2 uv_MainTex;
          float2 uv_NormalTex;
          float3 viewDir; 

          };
           void surf (Input IN, inout SurfaceOutput o)
          {   
              o.Albedo=_Albedo.rgb;
              fixed4 texColor=tex2D(_MainTex, IN.uv_MainTex);
              o.Albedo=_Albedo*texColor.rgb;
              fixed4 normalColor=tex2D(_NormalTex, IN.uv_NormalTex);
              //transforma 
              fixed3 normal=UnpackNormal(normalColor);
              o.Normal= normal; 
   ///ver 
             float3 nVD=normalize(IN.viewDir);
              float3 Ndot= dot(nVD, o.Normal);
              half rim= 1- saturate (Ndot);
              o.Emission= _RimColor.rgb * pow(rim,_RimPower); 
             
               

          }
        ENDCG
    }
}
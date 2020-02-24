Shader "Custom/SurfaceDiffuseTexture"
{
  Properties 
 {           //nombre,    tipo   
    _MainTex("Main Texture",2D)="white" {}
     _Albedo("Albedo Color",Color)=(1,1,1,1)

 }
  Subshader
 {
    Tags 
    {
        "Queve"="Geometry"
        "RenderType"="Opaque"  
    }
    CGPROGRAM 
    
       #pragma surface surf Lambert 
        half4 _Albedo; 
        sampler2D _MainTex;
        
        struct Input 
        {
         float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            half4 texColor = tex2D(_MainTex, IN.uv_MainTex);//color de la textura 
                         //textura y uv 
            o.Albedo = _Albedo * texColor.rgb;
            
        }

        
    ENDCG

 }

}
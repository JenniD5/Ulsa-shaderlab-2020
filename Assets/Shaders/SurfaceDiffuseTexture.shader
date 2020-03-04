Shader "Custom/SurfaceDiffuseTexture"
{
  Properties 
 {           //nombre,    tipo   colorenelquequeremosqueempiece
    _MainTex("Main Texture",2D)="white" {}
     _Albedo("Albedo Color",Color)=(1,1,1,1)

 }
  Subshader
 {
    Tags //como se va a renderear 
    {
        "Queve"="Geometry"  //quien se renderea primero = queve
        "RenderType"="Opaque"  //rendertype=como se renderea la luz
    }
    CGPROGRAM 
     //tipo de shader  como se llama a funcion que la va a rendear     
       #pragma surface surf Lambert  
        half4 _Albedo; //los colores son tipo 4, mismo nombre que en properties 

        sampler2D _MainTex; //para inicializarla 
        
        struct Input 
        {
         float2 uv_MainTex;
         //uv=cordenadas de dos dimensiones, es float porque debde de ser preciso 
        };
 //funcion que va a renderear   nombredelafuncion   
        void surf (Input IN, inout SurfaceOutput o)
        {         //nombre    entradadetextura
            half4 texColor = tex2D(_MainTex, IN.uv_MainTex);//color de la textura 
                         //textura y uv 
            o.Albedo = _Albedo * texColor.rgb;
            
        }

        
    ENDCG

 }

}
shader "Custom/SDUnion"
{
    Properties
    {
      _Albedo("Albedo Color", Color) = (1,1,1,1)
      _MainTex("Main Texture", 2D)= "white"{} 
      _Texture2("Texture", 2D)= "white"{} 
      _NormalMap("Normal Texture", 2D)= "bump" {}
     [HDR]_RimColor("Rim Color", Color) = (1,0,0,1)
      _RimPower("Rim Power", Range(0.0, 8.0)) = 1.0

    }
    SubShader
    {
        Tags
        {
      "Queve" = "Geometry"
      "RenderType "="Opaque"
        }
    
    CGPROGRAM
    #pragma surface surf Lambert
    half4 _Albedo;
    sampler2D _MainTex; 
    sampler2D _NormalMap;
    sampler2D _Texture2;
    half4 _RimColor;
    float _RimPower;

    struct Input
    {
      float2 uv_MainTex;
      float2 uv_NormalMap;
      float2 uv_Texture2;
      float3 viewDir;

    };
    
    void surf( Input IN, inout SurfaceOutput o)
    {
        fixed4 texColor= tex2D(_MainTex, IN.uv_MainTex);
        o.Albedo =_Albedo * texColor.rgb;
        fixed4 texNormal= tex2D(_NormalMap,IN.uv_NormalMap);
        fixed3 normal= UnpackNormal (texNormal);
        o.Normal=normal;
        fixed4 texColor2= tex2D(_Texture2, IN.uv_Texture2);
        o.Albedo =_Albedo * texColor2.rgb * texColor.rgb;
      
       float3 nVD = normalize(IN.viewDir);
       float3 NdotV= dot(nVD, o.Normal);
       half rim= 1- saturate (NdotV);
       o.Emission = _RimColor.rgb * pow (rim,_RimPower);


    }

    ENDCG
    }
}
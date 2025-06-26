
// All parameters are set in Common.

vec3 determineState( vec2 coord ) {
    vec4 pixel = texelFetch(iChannel0, ivec2(
           coord.x / (iResolution.x / detail), 
           (iResolution.y - coord.y) / (iResolution.x / detail)), 0);
    if (pixel.x == 1.0) {
        return colorOn;
    } else {
        return colorOff;
    }
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
   vec2 uv = fragCoord / iResolution.xy;
   if (visualizationLevel != 0) {
       fragColor = vec4(determineState(fragCoord), 1.0);
   } else {
       fragColor = texelFetch(iChannel0, ivec2(
           fragCoord.x,
           iResolution.y - fragCoord.y), 0);
   }
}


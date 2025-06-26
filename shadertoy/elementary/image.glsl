
bool visualize = true;
float detail = 64.0;

vec3 colorOff = vec3(1.0, 1.0, 1.0);
vec3 colorOn = vec3(0.0, 0.0, 0.0);

vec3 determineColor( vec2 coord ) {
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
   if (visualize) {
       fragColor = vec4(determineColor(fragCoord), 1.0);
   } else {
       fragColor = texelFetch(iChannel0, ivec2(
           fragCoord.x,
           iResolution.y - fragCoord.y), 0);
   }
}


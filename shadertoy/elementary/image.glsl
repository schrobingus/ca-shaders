
// All parameters are set in Common.

int determineRowValue(vec2 coord) {
    ivec2 pixel_xy = ivec2(
        coord.x / (iResolution.x / detail),
        (iResolution.y - coord.y) / (iResolution.x / detail)
    );
    
    vec4 pixel = texelFetch(iChannel0, pixel_xy, 0);
    if (pixel.r == 1.0) return 0;

    int value = 0;

    for (int x = pixel_xy.x - 1; x >= 0; --x) {
        vec4 pixel_r = texelFetch(iChannel0, ivec2(x, pixel_xy.y), 0);
        if (pixel_r.r == 1.0) break;
        value++;
    }
    for (int x = pixel_xy.x + 1; x < int(detail); ++x) {
        vec4 pixel_r = texelFetch(iChannel0, ivec2(x, pixel_xy.y), 0);
        if (pixel_r.r == 1.0) break;
        value++;
    }

    return value;
}

vec3 determineState(vec2 coord) {
    ivec2 pixel_xy = ivec2(
        coord.x / (iResolution.x / detail),
        (iResolution.y - coord.y) / (iResolution.x / detail)
    );
    vec4 pixel = texelFetch(iChannel0, pixel_xy, 0);
    if (pixel.x == 1.0) {
        return colorOn;
    } else {
        if (visualizationLevel == 2) {
            int rowValue = determineRowValue(coord);
            if (rowValue <= colorDigitCount) {
                return colorDigits[rowValue];
            }
        }
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


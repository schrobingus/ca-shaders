
float detail = 64.0;
int rule = 110;
float secondsPerUpdate = 1.0/30.0;

float eca(float a, float b, float c, int rule) {
    int idx = int(a) * 4 + int(b) * 2 + int(c);
    return float((rule >> idx) & 1);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    ivec2 prevResPixel = ivec2(detail, 0);
    ivec2 prevTimePixel = ivec2(detail, 1);

    ivec2 coord = ivec2(floor(fragCoord));
    
    int currentRow = int(ceil((iResolution.y) / (iResolution.x / detail))) - 1;

    vec4 col = vec4(0.0, 0.0, 0.0, 1.0);
    fragColor = col;
    
    vec2 prevRes = texelFetch(iChannel0, prevResPixel, 0).xy;
    bool resized = any(notEqual(prevRes, iResolution.xy));
    
    vec4 prevTime = texelFetch(iChannel0, prevTimePixel, 0);
    vec3 prevTimeSim = prevTime.rgb;
    float lastTime = prevTime.a;
    
    float dt = iTime - lastTime;
    bool doUpdate = 
        (secondsPerUpdate == 0.0) ||
        (lastTime == 0.0) || 
        (dt >= secondsPerUpdate);
    
    vec4 result = vec4(vec3(0.0), 1.0);
    
    float newTime = doUpdate ? iTime : lastTime;

    if (fragCoord.x >= detail) {
        if (coord.x == prevResPixel.x && coord.y == prevResPixel.y) {
            fragColor = vec4(iResolution.xy, 0.0, 1.0);
            return;
        }
        if (coord.x == prevTimePixel.x && coord.y == prevTimePixel.y) {
            fragColor = vec4(prevTime.rgb, newTime);
            return;
        }
        return;
    }

    if (resized) {
        if (coord.x == int(detail * 0.5) && coord.y == currentRow) {
            col = vec4(1.0);
        } else {
            col = vec4(0.0);
        }
    } else if (!doUpdate) {
        col = texelFetch(iChannel0, coord, 0);
    } else if (coord.y != currentRow) {
        col = texelFetch(iChannel0, coord + ivec2(0, 1), 0);
    }
    else {
        ivec2 left = ivec2(
            (coord.x - 1 + int(detail)) % int(detail), 
            coord.y);
        ivec2 mid = coord;
        ivec2 right = ivec2(
            (coord.x + 1) % int(detail), 
            coord.y);

        float a = texelFetch(iChannel0, left, 0).x;
        float b = texelFetch(iChannel0, mid, 0).x;
        float c = texelFetch(iChannel0, right, 0).x;

        float state = eca(a, b, c, rule);
        col = vec4(vec3(state), 1.0);
    }
    
    fragColor = col;
}


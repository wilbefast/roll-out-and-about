extern vec4 colors[15];
extern float rseed;
extern float ditherAmt;

float M_PI = 3.14159265;

float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

float hue2rgb(float p, float q, float t){
    if(t < 0) t += 1.0;
    if(t > 1) t -= 1.0;
    if(t < 1.0/6.0) return p + (q - p) * 6.0 * t;
    if(t < 1.0/2.0) return q;
    if(t < 2.0/3.0) return p + (q - p) * (2.0/3.0 - t) * 6.0;
    return p;
}

vec4 hslToRgb(vec4 col){
    float r, g, b;
    float h, s, l;
    h = col.r;
    s = col.g;
    l = col.b;


    if(s == 0){
        r = g = b = l; // achromatic
    }else{

        float q = (l < 0.5 ? l * (1.0 + s) : l + s - l * s);
        float p = 2.0 * l - q;
        r = hue2rgb(p, q, h + 1.0/3.0);
        g = hue2rgb(p, q, h);
        b = hue2rgb(p, q, h - 1.0/3.0);
    }

    return vec4(r,g,b,1);
}

vec4 rgbToHsl(vec4 col){
    float r,g,b;
    r = col.r;
    g = col.g;
    b = col.b;
    float max = max(r, max(g, b));
    float min = min(r, min(g, b));
    float h, s, l = (max + min) / 2;

    if(max == min){
        h = s = 0.0; // achromatic
    }else{
        float d = max - min;
        s = l > 0.5 ? d / (2.0 - max - min) : d / (max + min);
        
        if (max==r)
        	h = (g - b) / d + (g < b ? 6.0 : 0.0);
        if (max==g)
        	h = (b - r) / d + 2.0;
        if (max==b)
         	h = (r - g) / d + 4.0;
        h /= 6.0;
    }

    return vec4(h,s,l,1);
}

vec4 inv(vec4 c)
{

	vec4 hsl = rgbToHsl(vec4(c));
	hsl.g *=1.2;
	hsl.b = 1-hsl.b;

	return hslToRgb(hsl);
}

float dist32(vec4 a, vec4 b)
{
	vec4 d = b-a;
	return (d.r*d.r + d.g*d.g + d.b*d.b);
}

float dist3(vec4 a, vec4 b)
{
	return sqrt(dist32(a,b));
}

int getClosest(vec4 c, vec2 coord){
	int res = 4;
	float mindist = 10000;
	int i;
	for (i = 0; i < 15; ++i)
	{
		float dist = dist32(c, colors[i]);
		if (dist+ditherAmt*rand(coord+rseed)<mindist+ditherAmt*rand(coord+rseed+1))
		{
			mindist = dist;
			res = i;
		}
	}
	return res;
}


vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
{
	vec4 c = Texel(texture, texture_coords);
	int i = getClosest(c, texture_coords);
	return colors[i];

    // Normally:
    // return Texel(texture, texture_coords) * color;
}
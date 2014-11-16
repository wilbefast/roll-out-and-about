vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
{
	vec4 col = -step(vec4(0.5, 0.5, 0.5, 0.5), Texel(texture, texture_coords));
	col.a = -col.a;
  return col;
}
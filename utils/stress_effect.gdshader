shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture,
                                   repeat_disable,
                                   filter_nearest;

uniform float stress : hint_range(0.0, 1.) = 0.0;
uniform float max_amplitude =
    0.002; // How much to wave (in UV units, 0.02 ~ a few pixels)
uniform float frequency = 90.0; // Number of waves across the screen
uniform float speed = 2.0;      // Speed of the wave
uniform float stress_start = 0.6;

void fragment() {
  // Calculate wave offset for the Y coordinate
  float amplitude = smoothstep(stress_start, 1., stress) * max_amplitude;
  float left = smoothstep(0.0, 0.1, SCREEN_UV.x);
  float right = smoothstep(1.0, 0.9, SCREEN_UV.x);
  float edge_fade = left * right;
  float wave =
      amplitude * edge_fade * sin(SCREEN_UV.x * frequency + TIME * speed);
  vec2 uv = SCREEN_UV + vec2(wave, 0.0);

  // Sample the screen texture at the wavy UV
  vec3 c = texture(screen_texture, uv).rgb;

  float fade = clamp((stress - stress_start) / 0.2, 0.0, 1.0);
  c.g = mix(c.g, c.g * 0.5, fade);
  c.b = mix(c.b, c.b * 0.5, fade);

  COLOR.rgb = c;

  COLOR.a = 1.0;
}

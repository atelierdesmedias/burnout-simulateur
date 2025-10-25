shader_type canvas_item;

uniform vec2 top_left = vec2(0.0, 0.0);
uniform vec2 top_right = vec2(1.0, 0.0);
uniform vec2 bottom_right = vec2(1.0, 1.0);
uniform vec2 bottom_left = vec2(0.0, 1.0);

void vertex() {
    vec2 top = mix(top_left, top_right, UV.x);
    vec2 bottom = mix(bottom_left, bottom_right, UV.x);
    VERTEX = mix(top, bottom, UV.y);
}

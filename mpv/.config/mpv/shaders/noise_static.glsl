//!HOOK LUMA
//!BIND HOOKED
//!DESC Noise

// Strength of the noise.
#define STRENGTH (0.05)

// Source: <https://stackoverflow.com/a/4275343>
float rand(vec2 pos) {
  return fract(sin(dot(pos, vec2(12.9898, 78.233))) * 43758.5453);
}

vec4 hook() {
  return HOOKED_tex(HOOKED_pos) + vec4(STRENGTH) * (rand(HOOKED_pos) - 0.5);
}

// mograf port prelude — Apache-2.0 host, original file below keeps its own license header
precision highp float;
uniform sampler2D u_from;
uniform sampler2D u_to;
uniform float u_progress;
uniform vec2 u_resolution;
varying vec2 v_uv;
#define progress u_progress
#define ratio (u_resolution.x / u_resolution.y)
vec4 getFromColor(vec2 uv) { return texture2D(u_from, uv); }
vec4 getToColor(vec2 uv)   { return texture2D(u_to, uv); }

// ---- original gl-transitions file (gl-transitions/gl-transitions, MIT — full text in LICENSES/MIT-gl-transitions.txt), header intact ----
// Author: Eke Péter <peterekepeter@gmail.com>
// License: MIT
vec4 transition(vec2 p) {
  float x = progress;
  x=smoothstep(.0,1.0,(x*2.0+p.x-1.0));
  return mix(getFromColor((p-.5)*(1.-x)+.5), getToColor((p-.5)*x+.5), x);
}

void main() { gl_FragColor = transition(v_uv); }

//
// Generates the noisy surface of the sphere using fractal Brownian motion 
// (fbm) and spots, creating texture and complexity.
//

uniform float time;
varying vec2 vUv;
varying vec3 vPosition;
uniform vec2 pixels;
float PI = 3.141592653589793238;
void main() {
    vUv = uv;
    vPosition = position;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}
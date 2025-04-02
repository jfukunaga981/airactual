// varying vec3 vertexNormal; // (0, 0, 0)
// void main() {
//   float intensity = pow(0.75 - dot(vertexNormal, vec3(0, 0, 1.0)), 2.0);
//   gl_FragColor = vec4(0.3, 0.6, 1.0, 1.0) * intensity;
// }


// Fixes the atmosphere issue when the camera is closer
varying vec3 vertexNormal;
varying vec3 vertexPosition;

void main() {
  vec3 viewDirection = normalize(-vertexPosition);
  float intensity = pow(max(0.0, 0.6 - dot(vertexNormal, viewDirection)), 10.0);
  gl_FragColor = vec4(0.3, 0.6, 1.0, intensity);
}


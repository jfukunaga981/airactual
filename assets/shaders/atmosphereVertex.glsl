// varying vec3 vertexNormal;

// void main() {
//   vertexNormal = normalize(normalMatrix * normal);
//   gl_Position = projectionMatrix * modelViewMatrix * vec4( position, 0.9 );
// }

varying vec3 vertexNormal;
varying vec3 vertexPosition;

void main() {
  vertexNormal = normalize(normalMatrix * normal);
  vec4 mvPosition = modelViewMatrix * vec4(position, 1.0);
  vertexPosition = mvPosition.xyz;
  gl_Position = projectionMatrix * mvPosition;
}

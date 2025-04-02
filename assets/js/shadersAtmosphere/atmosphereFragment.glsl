//
// Original code from Chris Courses
// varying vec3 vertexNormal; // (0, 0, 0)
// void main() {
//   float intensity = pow(0.75 - dot(vertexNormal, vec3(0, 0, 1.0)), 2.0);
//   gl_FragColor = vec4(0.3, 0.6, 1.0, 1.0) * intensity;
// }
//

//
// ChatGPT generated code using Yuri Artiukh approach
varying vec3 vertexNormal; // (0, 0, 0)

// The brightnessToColor function from the "around" mesh shader
vec3 brightnessToColor(float b) {
  b *= 0.25;
  return (vec3(b, b * b, b * b * b * b) / 0.25) * 0.8;
}

void main() {
    // Calculate intensity based on the dot product of vertex normal and view direction
    float intensity = pow(0.5 - dot(vertexNormal, vec3(0, 0, 1.0)), 5.0);

    // Use intensity directly as brightness for the color
    float brightness = intensity * 3.0;

    // Apply the brightnessToColor function to get the same color as "around"
    vec3 color = brightnessToColor(brightness);

    // Set the final color using the calculated color and full opacity (alpha = 1.0)
    gl_FragColor = vec4(color, 1.0);
}

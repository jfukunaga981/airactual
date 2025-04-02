<template>
  <canvas ref="canvas" class="fixed inset-0 w-full h-full z-0"></canvas>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue';
import * as THREE from 'three';
import { GLTFLoader } from 'three/examples/jsm/loaders/GLTFLoader';

// Reference to the canvas element
const canvas = ref(null);

// Variables to store Three.js objects
let scene, camera, renderer, animationId;
let gltfModel = null; // Moved to top scope for accessibility

// Define rotation parameters
let angle = 0; // Current angle for rotation
const rotationSpeed = 0.001; // Speed at which the camera rotates
const radius = 5; // Decreased distance from the center for a closer view

// Initialize the Three.js scene
function initScene() {
  const canvasElement = canvas.value;

  // Create a new Three.js scene
  scene = new THREE.Scene();

  // Set up the camera
  camera = new THREE.PerspectiveCamera(
    54, // Reduced Field of View for a closer perspective
    window.innerWidth / window.innerHeight, // Use window dimensions
    0.1,
    10000 // Increased far clipping plane to accommodate stars
  );
  camera.position.set(0, 2, radius); // Updated to new radius

  // Set up the renderer
  renderer = new THREE.WebGLRenderer({ canvas: canvasElement, antialias: true });
  renderer.setSize(window.innerWidth, window.innerHeight); // Use window dimensions
  renderer.setPixelRatio(window.devicePixelRatio); // Set pixel ratio for sharpness

  // Add ambient light
  const ambientLight = new THREE.AmbientLight(0xffffff, 0.5);
  scene.add(ambientLight);

  // Add directional light
  const directionalLight = new THREE.DirectionalLight(0xffffff, 1);
  directionalLight.position.set(10, 10, 10);
  scene.add(directionalLight);

  // Initialize GLTFLoader
  const loader = new GLTFLoader();

  loader.load(
    '/models/building2/scene.gltf', // Replace with the actual path to your model
    function (gltf) {
      gltfModel = gltf.scene;
      // Set the position of the loaded GLTF model
      gltf.scene.position.set(0, 0, 0);
      // Set the scale of the loaded GLTF model
      gltf.scene.scale.set(0.03, 0.03, 0.03); // Adjusted scale for visibility
      scene.add(gltfModel);
    },
    function (xhr) {
      console.log(`${(xhr.loaded / xhr.total * 100).toFixed(2)}% loaded`);
    },
    function (error) {
      console.error('An error occurred while loading the GLTF model:', error);
      // Optionally, add fallback logic here
    }
  );

  // Handle window resize
  window.addEventListener('resize', onWindowResize);
}

// Animation loop
function animate() {
  animationId = requestAnimationFrame(animate);

  // Update the angle for rotation
  angle += rotationSpeed;

  // Calculate new camera position using polar coordinates
  camera.position.x = radius * Math.sin(angle);
  camera.position.z = radius * Math.cos(angle);
  camera.position.y = 2; // Optional: Adjust the height of the camera

  // Make the camera look at the center of the scene
  // Assuming the model is positioned at (0, -1, 0)
  camera.lookAt(new THREE.Vector3(0, -1, 0));

  // Render the scene
  renderer.render(scene, camera);
}

// Handle window resizing
function onWindowResize() {
  const width = window.innerWidth;
  const height = window.innerHeight;

  // Update camera aspect ratio and projection matrix
  camera.aspect = width / height;
  camera.updateProjectionMatrix();

  // Update renderer size and pixel ratio
  renderer.setSize(width, height);
  renderer.setPixelRatio(window.devicePixelRatio);
}

// Clean up Three.js resources
function disposeScene() {
  // Dispose GLTF Scene
  if (gltfModel) {
    scene.remove(gltfModel);
    gltfModel.traverse((child) => {
      if (child.isMesh) {
        child.geometry.dispose();
        if (child.material.isMaterial) {
          cleanMaterial(child.material);
        } else {
          // Handle multi-materials
          child.material.forEach((material) => cleanMaterial(material));
        }
      }
    });
    gltfModel = null;
  }

  // Dispose renderer
  if (renderer) {
    renderer.dispose();
    renderer.forceContextLoss();
    renderer.context = null;
    renderer.domElement = null;
    renderer = null;
  }

  // Remove window resize listener
  window.removeEventListener('resize', onWindowResize);
}

// Helper function to clean materials and textures
function cleanMaterial(material) {
  material.dispose();

  // Dispose textures
  for (const key in material) {
    const value = material[key];
    if (value && typeof value === 'object' && 'minFilter' in value) {
      value.dispose();
    }
  }
}

// Mount the scene and start animation
onMounted(() => {
  initScene();
  animate();
});

// Clean up when component is unmounted
onBeforeUnmount(() => {
  cancelAnimationFrame(animationId);
  disposeScene();
});
</script>

<style scoped>
canvas {
  display: block;
}
</style>

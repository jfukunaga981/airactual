<template>
  <canvas ref="canvas" class="fixed inset-0 w-full h-full z-0"></canvas>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue'
import * as THREE from 'three'

// Reference to the canvas element
const canvas = ref(null)

// Variables to store Three.js objects
let scene, camera, renderer, cube, animationId

// Initialize the Three.js scene
function initScene() {
  const canvasElement = canvas.value

  // Create a new Three.js scene
  scene = new THREE.Scene()

  // Set up the camera
  camera = new THREE.PerspectiveCamera(
    75,
    window.innerWidth / window.innerHeight,
    0.1,
    10000 // Increased far clipping plane to accommodate stars
  )
  camera.position.z = 5

  // Set up the renderer
  renderer = new THREE.WebGLRenderer({ canvas: canvasElement, antialias: true })
  renderer.setSize(window.innerWidth, window.innerHeight)
  renderer.setPixelRatio(window.devicePixelRatio)

  // Create a green cube
  const cubeGeometry = new THREE.BoxGeometry(1, 1, 1)
  const cubeMaterial = new THREE.MeshBasicMaterial({ color: 0x00ff00 })
  cube = new THREE.Mesh(cubeGeometry, cubeMaterial)
  scene.add(cube)

  // Handle window resize
  window.addEventListener('resize', onWindowResize)
}

// Animation loop
function animate() {
  animationId = requestAnimationFrame(animate)

  // Rotate the cube
  cube.rotation.x += 0.01
  cube.rotation.y += 0.01

  // Render the scene
  renderer.render(scene, camera)
}

// Handle window resizing
function onWindowResize() {
  const width = window.innerWidth
  const height = window.innerHeight

  camera.aspect = width / height
  camera.updateProjectionMatrix()

  renderer.setSize(width, height)
}

// Clean up Three.js resources
function disposeScene() {
  // Dispose cube geometry and material
  cube.geometry.dispose()
  cube.material.dispose()

  // Dispose renderer
  renderer.dispose()

  // Remove window resize listener
  window.removeEventListener('resize', onWindowResize)
}

// Mount the scene and start animation
onMounted(() => {
  initScene()
  animate()
})

// Clean up when component is unmounted
onBeforeUnmount(() => {
  cancelAnimationFrame(animationId)
  disposeScene()
})
</script>

<style scoped>
canvas {
  display: block;
}
</style>

<template>
  <canvas ref="canvas" class="fixed inset-0 w-full h-full z-0"></canvas>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue'
import * as THREE from 'three'

// Reference to the canvas element
const canvas = ref(null)

// Variables to store Three.js objects
let scene, camera, renderer, cube, stars, animationId

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

  // Add stars to the scene
  addStars()

  // Handle window resize
  window.addEventListener('resize', onWindowResize)
}

// Function to generate random points inside a sphere
function randomSpherePoint(radius = 1000) {
  const theta = 2 * Math.PI * Math.random()
  const phi = Math.acos(2 * Math.random() - 1)
  const r = radius * Math.cbrt(Math.random()) // Cubic root for uniform distribution

  const x = r * Math.sin(phi) * Math.cos(theta)
  const y = r * Math.sin(phi) * Math.sin(theta)
  const z = r * Math.cos(phi)

  return new THREE.Vector3(x, y, z)
}

// Function to add stars to the scene
function addStars() {
  // Create geometry and material for stars
  const starGeometry = new THREE.BufferGeometry()
  const starMaterial = new THREE.PointsMaterial({
    color: 0xffffff,
    size: 1.5, // Adjust size as needed
    sizeAttenuation: true, // Makes size consistent across distances
  })

  // Generate star vertices
  const starVertices = []
  const numStars = 10000
  const sphereRadius = 2000 // Radius of the sphere

  for (let i = 0; i < numStars; i++) {
    const starPosition = randomSpherePoint(sphereRadius)
    starVertices.push(starPosition.x, starPosition.y, starPosition.z)
  }

  // Set geometry attributes
  starGeometry.setAttribute(
    'position',
    new THREE.Float32BufferAttribute(starVertices, 3)
  )

  // Create Points object and add to scene
  stars = new THREE.Points(starGeometry, starMaterial)
  scene.add(stars)
}

// Animation loop
function animate() {
  animationId = requestAnimationFrame(animate)

  // Rotate the cube
  cube.rotation.x += 0.01
  cube.rotation.y += 0.01

  // Optional: Rotate the stars for a dynamic effect
  // stars.rotation.x += 0.0001
  stars.rotation.y += 0.0001

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

  // Dispose stars geometry and material
  stars.geometry.dispose()
  stars.material.dispose()

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

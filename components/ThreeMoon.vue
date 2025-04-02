<template>
  <canvas ref="canvas" class="fixed inset-0 w-full h-full z-0"></canvas>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue'
import * as THREE from 'three'

// Reference to the canvas element
const canvas = ref(null)

// Variables to store Three.js objects
let scene, camera, renderer, stars, moon, animationId

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

  // Add ambient light
  const ambientLight = new THREE.AmbientLight(0xffffff, 0.05) // Soft white light
  scene.add(ambientLight)

  // Add directional light
  const directionalLight = new THREE.DirectionalLight(0xffffff, 10)
  // directionalLight.position.set(5, 10, 7.5)
  directionalLight.position.set(-10, -10, -10)
  scene.add(directionalLight)

  // Create a green cube
  // const cubeGeometry = new THREE.BoxGeometry(1, 1, 1)
  // const cubeMaterial = new THREE.MeshBasicMaterial({ color: 0x00ff00 })
  // cube = new THREE.Mesh(cubeGeometry, cubeMaterial)
  // scene.add(cube)

  // Add stars to the scene
  addStars()

  // Add the Moon to the scene
  addMoon()

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

// Function to add the Moon to the scene
function addMoon() {
  // Load Moon textures using absolute paths
  const textureLoader = new THREE.TextureLoader()
  
  const moonTexture = textureLoader.load('/img/moonmap.jpg')
  moonTexture.colorSpace = THREE.SRGBColorSpace // Ensures correct color space
  
  const bumpTexture = textureLoader.load('/img/moonbump.jpg')
  bumpTexture.colorSpace = THREE.SRGBColorSpace // Ensures correct color space

  // Create Moon material
  const moonMaterial = new THREE.MeshStandardMaterial({
    map: moonTexture,
    bumpMap: bumpTexture,
    bumpScale: 0.05, // Adjust bump scale as needed
  })

  // Create Moon geometry and mesh
  const moonGeometry = new THREE.SphereGeometry(1, 64, 64) // Increased segments for smoother appearance
  moon = new THREE.Mesh(moonGeometry, moonMaterial)

  // Position the Moon
  moon.position.set(3, 0, 0) // Adjust position as needed

  // Tilt the Moon by adjusting its rotation
  moon.rotation.z = -6.7 * Math.PI / 180

  // Add Moon to the scene
  scene.add(moon)
}

// Animation loop
function animate() {
  animationId = requestAnimationFrame(animate)

  // Rotate the cube
  // cube.rotation.x += 0.01
  // cube.rotation.y += 0.01

  // Rotate the Moon (optional)
  if (moon) {
    moon.rotation.y += 0.001 // Adjust rotation speed as desired
  }

  // Optional: Rotate the stars for a dynamic effect
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
  // cube.geometry.dispose()
  // cube.material.dispose()

  // Dispose stars geometry and material
  stars.geometry.dispose()
  stars.material.dispose()

  // Dispose Moon geometry and material
  if (moon) {
    moon.geometry.dispose()
    moon.material.map.dispose()
    moon.material.bumpMap.dispose()
    moon.material.dispose()
  }

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

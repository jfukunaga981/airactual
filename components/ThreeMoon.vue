<template>
  <canvas ref="canvas" class="fixed inset-0 w-full h-full z-0"></canvas>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue'
import * as THREE from 'three'

// Reference to the canvas element
const canvas = ref(null)

// Three.js objects
let scene, camera, renderer, stars, moon, animationId

function initScene() {
  const canvasElement = canvas.value

  // Create scene
  scene = new THREE.Scene()

  // Set up camera
  camera = new THREE.PerspectiveCamera(
    75,
    window.innerWidth / window.innerHeight,
    0.1,
    10000
  )
  // Default camera position
  camera.position.z = 5

  // Renderer
  renderer = new THREE.WebGLRenderer({ canvas: canvasElement, antialias: true })
  renderer.setSize(window.innerWidth, window.innerHeight)
  renderer.setPixelRatio(window.devicePixelRatio)

  // Lights
  const ambientLight = new THREE.AmbientLight(0xffffff, 0.05)
  scene.add(ambientLight)

  const directionalLight = new THREE.DirectionalLight(0xffffff, 10)
  directionalLight.position.set(-10, -10, -10)
  scene.add(directionalLight)

  // Add stars
  addStars()

  // Add moon
  addMoon()

  // Listen for resizes
  window.addEventListener('resize', onWindowResize)
  // Also call it once right away, to handle first load on mobile
  onWindowResize()
}

function randomSpherePoint(radius = 1000) {
  const theta = 2 * Math.PI * Math.random()
  const phi = Math.acos(2 * Math.random() - 1)
  const r = radius * Math.cbrt(Math.random())

  const x = r * Math.sin(phi) * Math.cos(theta)
  const y = r * Math.sin(phi) * Math.sin(theta)
  const z = r * Math.cos(phi)
  return new THREE.Vector3(x, y, z)
}

function addStars() {
  const starGeometry = new THREE.BufferGeometry()
  const starMaterial = new THREE.PointsMaterial({
    color: 0xffffff,
    size: 1.5,
    sizeAttenuation: true
  })

  const starVertices = []
  const numStars = 10000
  const sphereRadius = 2000

  for (let i = 0; i < numStars; i++) {
    const starPosition = randomSpherePoint(sphereRadius)
    starVertices.push(starPosition.x, starPosition.y, starPosition.z)
  }

  starGeometry.setAttribute(
    'position',
    new THREE.Float32BufferAttribute(starVertices, 3)
  )
  stars = new THREE.Points(starGeometry, starMaterial)
  scene.add(stars)
}

function addMoon() {
  const textureLoader = new THREE.TextureLoader()
  const moonTexture = textureLoader.load('/img/moonmap.jpg')
  moonTexture.colorSpace = THREE.SRGBColorSpace

  const bumpTexture = textureLoader.load('/img/moonbump.jpg')
  bumpTexture.colorSpace = THREE.SRGBColorSpace

  const moonMaterial = new THREE.MeshStandardMaterial({
    map: moonTexture,
    bumpMap: bumpTexture,
    bumpScale: 0.05
  })
  // Sphere geometry
  const moonGeometry = new THREE.SphereGeometry(1, 64, 64)
  moon = new THREE.Mesh(moonGeometry, moonMaterial)

  // Default Moon position
  moon.position.set(3, 0, 0)
  // Slight tilt
  moon.rotation.z = -(6.7 * Math.PI) / 180

  scene.add(moon)
}

function animate() {
  animationId = requestAnimationFrame(animate)

  // Optional: slowly rotate the Moon
  if (moon) {
    moon.rotation.y += 0.001
  }

  // Optional: rotate starfield
  if (stars) {
    stars.rotation.y += 0.0001
  }

  renderer.render(scene, camera)
}

function onWindowResize() {
  const width = window.innerWidth
  const height = window.innerHeight

  // Update aspect
  camera.aspect = width / height
  camera.updateProjectionMatrix()

  // Example: If screen is narrower than 640px, move the camera back
  // and shift the Moon slightly, so it stays fully in frame.
  if (width < 640) {
    camera.position.z = 6    // Move camera further away
    moon.position.set(1, 0, 0) // Nudge the Moon left if needed
  } else {
    camera.position.z = 5
    moon.position.set(3, 0, 0)
  }

  renderer.setSize(width, height)
}

// Disposal
function disposeScene() {
  stars.geometry.dispose()
  stars.material.dispose()

  if (moon) {
    moon.geometry.dispose()
    moon.material.map.dispose()
    moon.material.bumpMap.dispose()
    moon.material.dispose()
  }

  renderer.dispose()
  window.removeEventListener('resize', onWindowResize)
}

onMounted(() => {
  initScene()
  animate()
})

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

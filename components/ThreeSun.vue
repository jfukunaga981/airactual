<template>
  <canvas ref="canvas" class="fixed inset-0 w-full h-full z-0"></canvas>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue'
import * as THREE from 'three'

import fragment from "~/assets/js/shaders/fragment.glsl?raw";
import fragmentSun from "~/assets/js/shadersSun/fragment.glsl?raw";
import vertex from "~/assets/js/shaders/vertex.glsl?raw";
import vertexSun from "~/assets/js/shadersSun/vertex.glsl?raw";
import atmosphereVertexShader from "~/assets/js/shadersAtmosphere/atmosphereVertex.glsl?raw";
import atmosphereFragmentShader from "~/assets/js/shadersAtmosphere/atmosphereFragment.glsl?raw";

// Reference to the canvas element
const canvas = ref(null)

// Variables to store Three.js objects
let scene, scene1, camera, renderer, stars, sunGroup, cubeRenderTarget, cubeCamera, materialSun, materialPerlin, animationId
let time = 0

// Initialize the Three.js scene
function initScene() {
  const canvasElement = canvas.value

  // Create main scene and secondary scene for reflections
  scene = new THREE.Scene()
  scene1 = new THREE.Scene()

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

  // Add stars to the scene
  addStars()

  // Add the Sun to the scene
  addSun()

  // Handle window resize
  window.addEventListener('resize', onWindowResize)
}

// Stars
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
  const starGeometry = new THREE.BufferGeometry()
  const starMaterial = new THREE.PointsMaterial({
    color: 0xffffff,
    size: 1.5,
    sizeAttenuation: true,
  })

  const starVertices = []
  const numStars = 10000
  const sphereRadius = 2000

  for (let i = 0; i < numStars; i++) {
    const starPosition = randomSpherePoint(sphereRadius)
    starVertices.push(starPosition.x, starPosition.y, starPosition.z)
  }

  starGeometry.setAttribute('position', new THREE.Float32BufferAttribute(starVertices, 3))

  stars = new THREE.Points(starGeometry, starMaterial)
  scene.add(stars)
}

function addSun() {
  sunGroup = new THREE.Group()
  
  cubeRenderTarget = new THREE.WebGLCubeRenderTarget(256, {
    format: THREE.RGBFormat,
    generateMipmaps: true,
    minFilter: THREE.LinearMipMapLinearFilter,
    encoding: THREE.sRGBEncoding,
  })
  cubeCamera = new THREE.CubeCamera(0.1, 10, cubeRenderTarget)

  materialSun = new THREE.ShaderMaterial({
    vertexShader: vertexSun,
    fragmentShader: fragmentSun,
    uniforms: {
      time: { value: 0 },
      uPerlin: { value: null },
      resolution: { value: new THREE.Vector4() },
    },
    side: THREE.DoubleSide,
  })

  const geometrySun = new THREE.SphereGeometry(1.5, 30, 30)
  const sun = new THREE.Mesh(geometrySun, materialSun)
  sunGroup.add(sun)

  const atmosphere = new THREE.Mesh(
    new THREE.SphereGeometry(1.8, 30, 30),
    new THREE.ShaderMaterial({
      vertexShader: atmosphereVertexShader,
      fragmentShader: atmosphereFragmentShader,
      blending: THREE.AdditiveBlending,
      side: THREE.BackSide
    })
  )
  atmosphere.scale.set(1.1, 1.1, 1.1)
  sunGroup.add(atmosphere)

  materialPerlin = new THREE.ShaderMaterial({
    vertexShader: vertex,
    fragmentShader: fragment,
    uniforms: {
      time: { value: 0 },
      resolution: { value: new THREE.Vector4() },
    },
    side: THREE.DoubleSide,
  })
  const perlinSphere = new THREE.Mesh(geometrySun, materialPerlin)
  scene1.add(perlinSphere)

  scene.add(sunGroup)
  sunGroup.position.set(0, 0, 0)
}

// Animation loop
function animate() {
  animationId = requestAnimationFrame(animate)

  stars.rotation.y += 0.0001

  time += 0.05
  materialSun.uniforms.time.value = time
  materialPerlin.uniforms.time.value = time

  cubeCamera.update(renderer, scene1)
  materialSun.uniforms.uPerlin.value = cubeRenderTarget.texture

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
  stars.geometry.dispose()
  stars.material.dispose()

  renderer.dispose()
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

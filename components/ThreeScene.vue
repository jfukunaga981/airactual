<template>
  <canvas ref="canvas"></canvas>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount, reactive } from 'vue'
import * as THREE from 'three'
import gsap from 'gsap'
import countries from '~/assets/data/countries.json'

// Import shaders (add '?raw' to import as strings)
import vertexShader from '~/assets/shaders/vertex.glsl?raw'
import fragmentShader from '~/assets/shaders/fragment.glsl?raw'
import atmosphereVertexShader from '~/assets/shaders/atmosphereVertex.glsl?raw'
import atmosphereFragmentShader from '~/assets/shaders/atmosphereFragment.glsl?raw'

// Reference to the canvas element
const canvas = ref(null)

// Reactive mouse state
const mouse = reactive({
  x: undefined,
  y: undefined,
  down: false,
  xPrev: undefined,
  yPrev: undefined,
})

// Variables to store Three.js objects
let scene, camera, renderer, group, raycaster

onMounted(() => {
  // Initialize the Three.js scene
  initThreeScene()
  // Start the animation loop
  animate()
  // Add event listeners
  addEventListeners()
})

onBeforeUnmount(() => {
  // Remove event listeners
  removeEventListeners()
  // Clean up Three.js resources
  renderer.dispose()
  // scene.dispose()
})

function initThreeScene() {
  const canvasContainer = canvas.value.parentElement

  // Create a new Three.js scene
  scene = new THREE.Scene()

  // Create a new perspective camera
  camera = new THREE.PerspectiveCamera(
    75,
    canvasContainer.offsetWidth / canvasContainer.offsetHeight,
    0.1,
    1000
  )
  camera.position.z = 15

  // Set camera position based on screen size
  setCameraPosition()

  // Create a WebGL renderer
  renderer = new THREE.WebGLRenderer({
    antialias: true,
    canvas: canvas.value,
  })
  renderer.setSize(canvasContainer.offsetWidth, canvasContainer.offsetHeight)
  renderer.setPixelRatio(window.devicePixelRatio)

  // Create the globe mesh with a custom shader material
  const sphere = new THREE.Mesh(
    new THREE.SphereGeometry(5, 50, 50),
    new THREE.ShaderMaterial({
      vertexShader,
      fragmentShader,
      uniforms: {
        globeTexture: {
          value: new THREE.TextureLoader().load('/img/globe2.jpg'),
        },
      },
    })
  )
  sphere.rotation.y = -Math.PI / 2 // Rotate the globe to the correct orientation

  // Create the atmosphere mesh
  const atmosphere = new THREE.Mesh(
    new THREE.SphereGeometry(5, 50, 50),
    new THREE.ShaderMaterial({
      vertexShader: atmosphereVertexShader,
      fragmentShader: atmosphereFragmentShader,
      blending: THREE.AdditiveBlending,
      side: THREE.BackSide,
    })
  )
  atmosphere.scale.set(1.1, 1.1, 1.1) // Slightly larger than the globe
  scene.add(atmosphere)

  // Create a group to hold the globe and other objects
  group = new THREE.Group()
  group.add(sphere)
  group.rotation.offset = { x: 0, y: 0 } // Initialize rotation offsets
  scene.add(group)

  // Create stars and add them to the scene
  createStars()

  // Create boxes for each country
  createBoxes(countries)

  // Initialize the raycaster for mouse interaction
  raycaster = new THREE.Raycaster()
}

function setCameraPosition() {
  const width = window.innerWidth;
  let targetZ = 15; // Default for large screens

  if (width < 640) { // Small screens (Mobile)
    targetZ = 10;
  } else if (width < 1024) { // Medium screens (Tablet)
    targetZ = 12;
  } else if (width < 1280) { // Large medium screens (Large Tablets/Laptops)
    targetZ = 14;
  } else { // Extra large screens (Desktop and above)
    targetZ = 15;
  }

  // Animate the camera's z position to the target value using GSAP for a smooth transition
  gsap.to(camera.position, {
    z: targetZ,
    duration: 1,
    ease: 'power2.out',
  });
}

function createStars() {
  const starGeometry = new THREE.BufferGeometry()
  const starMaterial = new THREE.PointsMaterial({
    color: 0xffffff,
  })

  const starVertices = []
  for (let i = 0; i < 10000; i++) {
    const x = (Math.random() - 0.5) * 2000
    const y = (Math.random() - 0.5) * 2000
    const z = -Math.random() * 3000
    starVertices.push(x, y, z)
  }

  starGeometry.setAttribute(
    'position',
    new THREE.Float32BufferAttribute(starVertices, 3)
  )

  const stars = new THREE.Points(starGeometry, starMaterial)
  scene.add(stars)
}

function createBoxes(countries) {
  countries.forEach((country) => {
    const scale = country.population / 1000000000
    const lat = country.latlng[0]
    const lng = country.latlng[1]
    const zScale = 0.8 * scale

    const box = new THREE.Mesh(
      new THREE.BoxGeometry(
        Math.max(0.1, 0.2 * scale),
        Math.max(0.1, 0.2 * scale),
        Math.max(zScale, 0.4 * Math.random())
      ),
      new THREE.MeshBasicMaterial({
        color: '#3BF7FF',
        opacity: 0.4,
        transparent: true,
      })
    )

    const latitude = (lat / 180) * Math.PI
    const longitude = (lng / 180) * Math.PI
    const radius = 5

    const x = radius * Math.cos(latitude) * Math.sin(longitude)
    const y = radius * Math.sin(latitude)
    const z = radius * Math.cos(latitude) * Math.cos(longitude)

    box.position.set(x, y, z)
    box.lookAt(0, 0, 0)
    box.geometry.applyMatrix4(
      new THREE.Matrix4().makeTranslation(0, 0, -zScale / 2)
    )

    group.add(box)

    // Animate the boxes
    gsap.to(box.scale, {
      z: 1.4,
      duration: 2,
      yoyo: true,
      repeat: -1,
      ease: 'linear',
      delay: Math.random(),
    })

    // Attach data to the box
    box.country = country.name
    box.population = new Intl.NumberFormat().format(country.population)
  })
}

function animate() {
  requestAnimationFrame(animate)
  renderer.render(scene, camera)
  group.rotation.y += 0.0005 // Rotate the globe slowly

  // Update the picking ray with the camera and mouse position
  raycaster.setFromCamera({ x: mouse.x, y: mouse.y }, camera)

  // Calculate objects intersecting the picking ray
  const intersects = raycaster.intersectObjects(
    group.children.filter((mesh) => mesh.geometry.type === 'BoxGeometry')
  )

  // Reset opacity of all boxes
  group.children.forEach((mesh) => {
    if (mesh.material && mesh.geometry.type === 'BoxGeometry') {
      mesh.material.opacity = 0.4
    }
  })

  // Hide the pop-up element
  gsap.set(popUpEl.value, {
    display: 'none',
  })

  // If an intersection occurs, highlight the box and show pop-up
  if (intersects.length > 0) {
    const box = intersects[0].object
    box.material.opacity = 1
    gsap.set(popUpEl.value, {
      display: 'block',
    })
    populationEl.value.innerHTML = box.country
    populationValueEl.value.innerHTML = box.population
  }
}

function addEventListeners() {
  const canvasContainer = canvas.value.parentElement

  // Attach event listeners to the canvas container
  canvasContainer.addEventListener('mousedown', onMouseDown)
  canvasContainer.addEventListener('mousemove', onMouseMove)
  canvasContainer.addEventListener('mouseup', onMouseUp)
  window.addEventListener('resize', onWindowResize)
  canvasContainer.addEventListener('touchstart', onTouchStart, { passive: false })
  canvasContainer.addEventListener('touchmove', onTouchMove, { passive: false })
  canvasContainer.addEventListener('touchend', onTouchEnd)
}

function removeEventListeners() {
  const canvasContainer = canvas.value.parentElement

  canvasContainer.removeEventListener('mousedown', onMouseDown)
  canvasContainer.removeEventListener('mousemove', onMouseMove)
  canvasContainer.removeEventListener('mouseup', onMouseUp)
  window.removeEventListener('resize', onWindowResize)
  canvasContainer.removeEventListener('touchstart', onTouchStart)
  canvasContainer.removeEventListener('touchmove', onTouchMove)
  canvasContainer.removeEventListener('touchend', onTouchEnd)
}

// Event handler functions
function onMouseDown(event) {
  mouse.down = true
  mouse.xPrev = event.clientX
  mouse.yPrev = event.clientY
}

function onMouseMove(event) {
  const canvasContainer = canvas.value.parentElement
  const canvasBounds = canvasContainer.getBoundingClientRect()

  mouse.x =
    ((event.clientX - canvasBounds.left) / canvasBounds.width) * 2 - 1
  mouse.y =
    -((event.clientY - canvasBounds.top) / canvasBounds.height) * 2 + 1

  // Position the pop-up element
  gsap.set(popUpEl.value, {
    x: event.clientX,
    y: event.clientY,
  })

  if (mouse.down) {
    event.preventDefault()
    const deltaX = event.clientX - mouse.xPrev
    const deltaY = event.clientY - mouse.yPrev

    group.rotation.offset.x += deltaY * 0.005
    group.rotation.offset.y += deltaX * 0.005

    gsap.to(group.rotation, {
      x: group.rotation.offset.x,
      y: group.rotation.offset.y,
      duration: 2,
    })

    mouse.xPrev = event.clientX
    mouse.yPrev = event.clientY
  }
}

function onMouseUp() {
  mouse.down = false
}

function onWindowResize() {
  const canvasContainer = canvas.value.parentElement
  renderer.setSize(canvasContainer.offsetWidth, canvasContainer.offsetHeight)
  camera.aspect = canvasContainer.offsetWidth / canvasContainer.offsetHeight
  camera.updateProjectionMatrix()

  // Update camera position based on new window size
  setCameraPosition()
}

function onTouchStart(event) {
  if (event.touches.length === 1) {
    mouse.down = true
    mouse.xPrev = event.touches[0].clientX
    mouse.yPrev = event.touches[0].clientY
  }
}

function onTouchMove(event) {
  event.preventDefault()

  if (event.touches.length !== 1) return

  event.clientX = event.touches[0].clientX
  event.clientY = event.touches[0].clientY

  const canvasContainer = canvas.value.parentElement
  const canvasBounds = canvasContainer.getBoundingClientRect()

  mouse.x =
    ((event.clientX - canvasBounds.left) / canvasBounds.width) * 2 - 1
  mouse.y =
    -((event.clientY - canvasBounds.top) / canvasBounds.height) * 2 + 1

  // Position the pop-up element
  gsap.set(popUpEl.value, {
    x: event.clientX,
    y: event.clientY,
  })

  if (mouse.down) {
    const deltaX = event.clientX - mouse.xPrev
    const deltaY = event.clientY - mouse.yPrev

    group.rotation.offset.x += deltaY * 0.005
    group.rotation.offset.y += deltaX * 0.005

    gsap.to(group.rotation, {
      x: group.rotation.offset.x,
      y: group.rotation.offset.y,
      duration: 2,
    })

    mouse.xPrev = event.clientX
    mouse.yPrev = event.clientY
  }
}

function onTouchEnd() {
  mouse.down = false
}

// References to the pop-up DOM elements
const popUpEl = ref(null)
const populationEl = ref(null)
const populationValueEl = ref(null)

onMounted(() => {
  // Use refs to access the elements
  popUpEl.value = document.getElementById('popUpEl')
  populationEl.value = document.getElementById('populationEl')
  populationValueEl.value = document.getElementById('populationValueEl')

  // Initialize the Three.js scene
  initThreeScene()
  // Start the animation loop
  animate()
  // Add event listeners
  addEventListeners()
})
</script>

<style scoped>
canvas {
  display: block;
  width: 100%;
  height: 100%;
}
</style>

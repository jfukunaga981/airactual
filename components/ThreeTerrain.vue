<template>
  <canvas ref="canvas"></canvas>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue'
import * as THREE from 'three'
import GUI from 'lil-gui'

import heightmap1 from '/img/heightmap1.png'
import heightmap2 from '/img/heightmap2.png'
import heightmap3 from '/img/heightmap3.png'

// Reference to the canvas element
const canvas = ref(null)

// Reference to store GUI instance
let gui = null

// References for Three.js objects
let scene, camera, renderer, groundMesh, gridLines

// Rotation parameters for the camera
let angle = 0
const rotationSpeed = 0.001
const radius = 60

// Define plane size and segmentation
const planeSize = 150 // Plane will be 150 x 150 units
// (Actual segments come from sliders below)
const sliders = {
  widthSeg: 200,
  heightSeg: 200,
  dispScale: 15,
  heightMap: heightmap1,
}

const availableMaps = {
  'Mount Diablo': heightmap1,
  'Angel Island': heightmap2,
  'Mount Everest': heightmap3,
}

/**
 * Load an image from URL and return a Promise that resolves with its pixel data.
 */
function loadImageData(url) {
  return new Promise((resolve, reject) => {
    const img = new Image()
    img.crossOrigin = 'anonymous'
    img.src = url
    img.onload = () => {
      const canvasImg = document.createElement('canvas')
      canvasImg.width = img.width
      canvasImg.height = img.height
      const ctx = canvasImg.getContext('2d')
      ctx.drawImage(img, 0, 0)
      const imageData = ctx.getImageData(0, 0, img.width, img.height)
      resolve({
        data: imageData.data,
        width: img.width,
        height: img.height,
      })
    }
    img.onerror = reject
  })
}

/**
 * Sample the red channel (normalized) from the image data and compute displacement.
 * This uses (red - 0.5) * dispScale to mimic the default behavior.
 */
function sampleDisplacement(u, v, imgData, dispScale) {
  const x = Math.floor(u * imgData.width)
  const y = Math.floor(v * imgData.height)
  const index = (y * imgData.width + x) * 4
  const red = imgData.data[index] / 255
  return (red - 0.5) * dispScale
}

/**
 * Create a custom Plane Geometry with CPU displacement.
 * The geometry will span width x height (centered at origin) and be subdivided into
 * widthSeg x heightSeg cells. For each vertex, the vertical (y) coordinate is set
 * to the displacement value computed from the heightmap.
 */
function createDisplacedPlaneGeometry(width, height, widthSeg, heightSeg, imgData, dispScale) {
  const rows = heightSeg + 1
  const cols = widthSeg + 1
  const vertexCount = rows * cols
  const positions = new Float32Array(vertexCount * 3)
  const uvs = new Float32Array(vertexCount * 2)

  // Loop over grid vertices.
  for (let i = 0; i < rows; i++) {
    // z coordinate: from -height/2 to +height/2
    const z = -height / 2 + (i * height) / heightSeg
    for (let j = 0; j < cols; j++) {
      const index = i * cols + j
      // x coordinate: from -width/2 to +width/2
      const x = -width / 2 + (j * width) / widthSeg
      // UV coordinates (0..1)
      const u = (x + width / 2) / width
      const v = (z + height / 2) / height
      // Compute displacement from heightmap.
      const disp = sampleDisplacement(u, v, imgData, dispScale)
      // We want the terrain to lie in the XZ plane, with Y up.
      positions[index * 3] = x      // X remains
      positions[index * 3 + 1] = disp   // Y is the displacement (height)
      positions[index * 3 + 2] = z      // Z coordinate spans the plane depth

      uvs[index * 2] = u
      uvs[index * 2 + 1] = v
    }
  }

  const geometry = new THREE.BufferGeometry()
  geometry.setAttribute('position', new THREE.BufferAttribute(positions, 3))
  geometry.setAttribute('uv', new THREE.BufferAttribute(uvs, 2))

  // Build indices for a standard grid (two triangles per cell)
  const indices = []
  for (let i = 0; i < heightSeg; i++) {
    for (let j = 0; j < widthSeg; j++) {
      const a = i * cols + j
      const b = a + 1
      const c = a + cols
      const d = c + 1
      indices.push(a, b, d)
      indices.push(a, d, c)
    }
  }
  geometry.setIndex(indices)
  geometry.computeVertexNormals()
  return geometry
}

/**
 * Create grid lines (as a BufferGeometry) by connecting the vertices of the displaced plane.
 */
function createGridLinesFromGeometry(geometry, widthSeg, heightSeg) {
  const posAttr = geometry.attributes.position
  const rows = heightSeg + 1
  const cols = widthSeg + 1
  const gridVertices = []

  // Helper to get a vertex at (r, c)
  function getVertex(r, c) {
    const index = r * cols + c
    return [
      posAttr.getX(index),
      posAttr.getY(index),
      posAttr.getZ(index)
    ]
  }

  // Horizontal segments
  for (let r = 0; r < rows; r++) {
    for (let c = 0; c < cols - 1; c++) {
      gridVertices.push(...getVertex(r, c), ...getVertex(r, c + 1))
    }
  }
  // Vertical segments
  for (let c = 0; c < cols; c++) {
    for (let r = 0; r < rows - 1; r++) {
      gridVertices.push(...getVertex(r, c), ...getVertex(r + 1, c))
    }
  }
  
  const gridGeometry = new THREE.BufferGeometry()
  gridGeometry.setAttribute(
    'position',
    new THREE.BufferAttribute(new Float32Array(gridVertices), 3)
  )
  return gridGeometry
}

/**
 * Create the ground mesh (CPU-displaced) and overlay grid lines.
 */
async function createGround() {
  // Clean up previous mesh and grid lines.
  if (groundMesh) {
    scene.remove(groundMesh)
    groundMesh.geometry.dispose()
    groundMesh.material.dispose()
    groundMesh = null
  }
  if (gridLines) {
    scene.remove(gridLines)
    gridLines.geometry.dispose()
    gridLines.material.dispose()
    gridLines = null
  }

  let imgData
  try {
    imgData = await loadImageData(sliders.heightMap)
  } catch (e) {
    console.error('Failed to load image data', e)
    return
  }

  // Create our custom CPU-displaced plane geometry.
  const displacedGeo = createDisplacedPlaneGeometry(
    planeSize,
    planeSize,
    sliders.widthSeg,
    sliders.heightSeg,
    imgData,
    sliders.dispScale
  )

  // Create a MeshStandardMaterial that is fully opaque.
  const groundMat = new THREE.MeshBasicMaterial({
    color: 0x000000,
    side: THREE.DoubleSide
  })

  // Create the ground mesh.
  groundMesh = new THREE.Mesh(displacedGeo, groundMat)
  scene.add(groundMesh)

  // Build grid lines from the same geometry.
  const gridGeometry = createGridLinesFromGeometry(displacedGeo, sliders.widthSeg, sliders.heightSeg)
  // Use a white line material; depthTest is disabled so the grid is always visible.
  const gridMaterial = new THREE.LineBasicMaterial({ color: 0xffffff, depthTest: true })
  gridLines = new THREE.LineSegments(gridGeometry, gridMaterial)
  scene.add(gridLines)
}

/**
 * Animation loop – rotates the camera.
 */
function animate() {
  angle += rotationSpeed
  camera.position.x = radius * Math.sin(angle)
  camera.position.z = radius * Math.cos(angle)
  camera.position.y = 5
  camera.lookAt(0, 0, 0)
  renderer.render(scene, camera)
}

/**
 * Initialize the Three.js scene.
 */
function initThreeScene() {
  scene = new THREE.Scene()
  // Optional: set a background color.
  scene.background = new THREE.Color(0x000000)

  const aspect = window.innerWidth / window.innerHeight
  camera = new THREE.PerspectiveCamera(75, aspect, 0.1, 1000)
  camera.position.set(radius, 15, 0)
  camera.lookAt(0, 0, 0)

  renderer = new THREE.WebGLRenderer({ canvas: canvas.value, antialias: true })
  renderer.setSize(window.innerWidth, window.innerHeight)
  renderer.setPixelRatio(window.devicePixelRatio)
  renderer.setAnimationLoop(animate)

  // Initialize GUI with autoPlace = false so we can attach it to a custom element
  gui = new GUI({ title: 'Digital Elevation Models', autoPlace: false })
  gui.domElement.classList.add('custom-lil-gui')
  // REMOVE the 'fixed' positioning so it can scroll with the page:
  // gui.domElement.style.position = 'fixed';  <-- Removed
  // We also remove top/bottom/right settings to let it be in normal flow.

  // If you want to place it in a specific element, for example #headerRightCell:
  const mountTarget = document.querySelector('#headerRightCell')
  if (mountTarget) {
    mountTarget.appendChild(gui.domElement)
  } else {
    console.warn('No #headerRightCell found. GUI will not be attached.')
  }

  // We no longer need updateGUIPosition() calls for a fixed overlay.

  gui
    .add(sliders, 'heightMap', availableMaps)
    .name('Select Location')
    .onChange(() => createGround())

  // Create the terrain.
  createGround()

  window.addEventListener('resize', onWindowResize)
}

/*
// This function used to handle fixed positioning. We'll comment it out 
// since we no longer want a fixed overlay that updates on resize.

// function updateGUIPosition() {
//   const isMobile = window.innerWidth <= 768;
//   const isLandscape = window.innerWidth > window.innerHeight;
//   ...
// }
*/

/**
 * Handle window resize.
 */
function onWindowResize() {
  const width = window.innerWidth
  const height = window.innerHeight
  camera.aspect = width / height
  camera.updateProjectionMatrix()
  renderer.setSize(width, height)
}

/**
 * Cleanup resources.
 */
function cleanup() {
  if (gui) {
    gui.destroy()
    gui = null
  }
  window.removeEventListener('resize', onWindowResize)
  // window.removeEventListener('resize', updateGUIPosition); // No longer needed

  if (renderer) {
    renderer.dispose()
    renderer.forceContextLoss()
    renderer.context = null
    renderer.domElement = null
    renderer = null
  }
  if (scene) {
    scene.traverse((object) => {
      if (object.geometry) object.geometry.dispose()
      if (object.material) {
        if (Array.isArray(object.material)) {
          object.material.forEach((m) => m.dispose())
        } else {
          object.material.dispose()
        }
      }
    })
  }
}

onMounted(() => {
  initThreeScene()
})

onBeforeUnmount(() => {
  cleanup()
})
</script>

<style>
canvas {
  display: block;
}

/* Overall lil-gui panel style */
.custom-lil-gui {
  background-color: rgba(0, 0, 0, 0.8) !important;
  color: #fff;
  font-family: 'Arial', sans-serif;
  border: 1px solid #CCCCCC;
  border-radius: 8px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5);
  padding: 15px;
  opacity: 0.95;
  transition: background-color 0.3s ease, box-shadow 0.3s ease;
}

/* You can keep all these styles for lil-gui elements */
.custom-lil-gui .title {
  font-size: 16px;
  font-weight: bold;
  color: #f0f0f0;
  margin-bottom: 10px;
}
.custom-lil-gui .folder {
  border-top: 1px solid #555;
  margin-top: 10px;
  padding-top: 10px;
}
/* Style the sliders (input[type=range]) */
.custom-lil-gui input[type="range"] {
  width: 100%;
  height: 6px;
  border-radius: 5px;
  background: #444;
  outline: none;
  opacity: 0.8;
  transition: opacity 0.2s;
}
.custom-lil-gui input[type="range"]::-webkit-slider-thumb {
  -webkit-appearance: none;
  appearance: none;
  width: 12px;
  height: 12px;
  background: #f0f0f0;
  border-radius: 50%;
  cursor: pointer;
}
.custom-lil-gui input[type="range"]::-moz-range-thumb {
  width: 12px;
  height: 12px;
  background: #f0f0f0;
  border: none;
  border-radius: 50%;
  cursor: pointer;
}

/* Style number input fields */
.custom-lil-gui input[type="number"] {
  background-color: #333;
  color: #fff;
  border: 1px solid #555;
  padding: 4px;
  width: 50px;
  font-size: 12px;
}

/* Style dropdowns (select elements) */
.custom-lil-gui select {
  background-color: #444;
  color: #fff;
  border: 1px solid #555;
  padding: 4px;
  border-radius: 5px;
  font-size: 12px;
  transition: background-color 0.2s ease;
}
.custom-lil-gui select:hover {
  background-color: #555;
}
.custom-lil-gui select:focus {
  border-color: #888;
  outline: none;
}

/* Buttons inside lil-gui */
.custom-lil-gui .button {
  background-color: #333;
  color: #fff;
  border: 1px solid #555;
  border-radius: 5px;
  padding: 5px 10px;
  cursor: pointer;
  text-align: center;
  transition: background-color 0.2s ease;
}
.custom-lil-gui .button:hover {
  background-color: #555;
}

/* Toggle button (folders) */
.custom-lil-gui .title {
  background-color: #444;
  color: #fff;
  padding: 5px 10px;
  border-radius: 5px;
  font-size: 14px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}
.custom-lil-gui .title:hover {
  background-color: #555;
}
.custom-lil-gui .title.active {
  background-color: #666;
}

/* Label styling */
.custom-lil-gui label {
  font-size: 12px;
  color: #aaa;
  margin-bottom: 5px;
  display: block;
}
</style>

<template>
  <div>
    <!-- Pop-up element -->
    <div
      id="popUpEl"
      ref="popUpEl"
      class="bg-black bg-opacity-75 fixed px-4 py-2 rounded-lg pointer-events-none z-10"
    >
      <h2 class="text-white text-xs">
        <span id="populationEl" ref="populationEl"></span>
        <span> Population</span>
      </h2>
      <p
        id="populationValueEl"
        ref="populationValueEl"
        class="text-white font-bold text-lg"
      ></p>
    </div>

    <div class="bg-black xl:flex xl:h-[80vh]">
      <div class="xl:w-1/2 flex flex-col justify-center px-8 pt-32 pb-20 xl:pt-0">
        <div class="max-w-lg mx-auto">
          <h1>
            <em>Elevate your view with drone & GIS services</em>
          </h1>
          <p>
            High-resolution aerial imagery and precise 
            geospatial data to help you make informed decisions.
          </p>
          <br>
          <br>
          <div>
            <NuxtLink
              to="/contact"
              class="text-white bg-gnomon-blue inline-block px-8 py-4 rounded-full font-lato"
            >
              Get in touch
            </NuxtLink>
          </div>
        </div>
      </div>
      <div class="w-full h-[50vh] xl:w-1/2 xl:h-[90vh] relative" id="canvasContainer">
        <!-- Three.js canvas component -->
        <ThreeScene />
      </div>
    </div>
 
    <!-- New Section: CONTACT US with Three Columns and Two Rows -->
    <div class="gp-section">
      <div class="feature-section">
        <div class="feature-section-inner">
          <header class="section-header">
            <h2>Aerial and geospatial services that enhance your projects</h2>
            <p>
              From 4K photography to GIS integration, our drone 
              technology delivers unique perspectives and 
              actionable insights. Stand out and succeed with 
              expert aerial and geospatial services.
            </p>
          </header>
          <section class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <!-- First Column -->
            <div class="feature-card">
              <h3>📸 Aerial Photography & Videography</h3>
              <p>
                Capture high-resolution images and 4K videos for 
                real estate, events, and marketing. Showcase 
                stunning aerial views that enhance your visual 
                storytelling.<br>
              </p>
            </div>
            <!-- Second Column -->
            <div class="feature-card">
              <h3>🌐 360-Degree Panoramas</h3>
              <p>
                Create immersive, interactive experiences with 
                highest quality High Dynamic Range 360° Panoramas. 
                Perfect for virtual tours and presentations that 
                engage and captivate your audience.<br>
              </p>
            </div>
            <!-- Third Column -->
            <div class="feature-card">
              <h3>🗺️ Photogrammetry & Mapping</h3>
              <p>
                Generate precise 2D maps and 3D models for 
                construction, land surveying, and environmental 
                monitoring. Visualize complex data with 
                incredible detail and accuracy.<br>
              </p>
            </div>
            <!-- Fourth Column -->
            <div class="feature-card">
              <h3>🌍 GIS Integration</h3>
              <p>
                Transform geospatial data into actionable 
                insights for urban planning, environmental 
                management, and infrastructure development. 
                Make informed decisions with powerful GIS 
                analysis.<br>
              </p>
            </div>
            <!-- Fifth Column -->
            <div class="feature-card">
              <h3>🛠️ Inspections & Surveys</h3>
              <p>
                Safely inspect hard-to-reach areas with drone 
                technology. Get real-time data and high-quality 
                imagery for infrastructure, agriculture, and 
                environmental assessments.<br>
              </p>
            </div>
            <!-- Sixth Column -->
            <div class="feature-card">
              <h3>🏗️ Construction Services</h3>
              <p>
                Monitor project progress with aerial imaging and data. 
                Track timelines, budgets, and showcase project 
                milestones with detailed visuals and insights.<br>
              </p>
            </div>
          </section>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import ThreeScene from '~/components/ThreeScene.vue'
</script>

<style scoped>
/* Ensure the pop-up doesn't capture pointer events */
.pointer-events-none {
  pointer-events: none;
}
</style>

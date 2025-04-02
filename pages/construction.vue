<template>
  <div class="relative min-h-screen bg-gray-900">
    <!-- Three.js Scene Component -->
    <!-- This component renders a Three.js scene as a fixed background layer covering the entire screen -->
    <ThreeGltf class="fixed inset-0 w-full h-full z-0" />

    <!-- Contact Content Overlay -->
    <!-- Overlay container for the main content, positioned relative to the background -->
    <div class="relative flex flex-col items-center justify-start bg-black bg-opacity-0 pt-20 pt-[62px]">
      <!-- Padding to avoid overlap with fixed header -->

      <!-- Main Content Wrapper -->
      <!-- Wrapper for the content sections with semi-transparent background -->
      <div class="header-fullwidth-container">
        <div class="header-section">
          <div class="header-section-inner">
            <div class="header-section-left">
              <h1>Drone Construction Services</h1>
              <p>
                Advanced drone solutions to streamline your <br>construction projects
              </p>
              <div class="mt-5">
                <NuxtLink
                  to="/contact"
                  class="header-button"
                >
                  Get in touch
                </NuxtLink>
              </div>
            </div>
            <div class="header-section-right">
              <!-- Add your image or other content here -->
              <!-- <img src="path-to-your-image.jpg" alt="Description" class="your-classes" /> -->
            </div>
          </div>
        </div>
      </div>
      
      <!-- Additional Content Sections Wrapper -->
      <div class="content-section">
        
        <header class="header-container">
            <h2 class="text-shadow-[0_4px_4px_rgba(0,0,0,0.75)]">Gain clarity, improve safety, and boost efficiency with 
              powerful aerial insights</h2>
            <p class="text-white text-shadow-[0_4px_4px_rgba(0,0,0,0.75)]">
              Managing construction sites can be challenging—miscommunications, 
              delays, and unexpected costs create frustration and risk.<br>
              <br>
              Drones deliver advanced imaging and precise aerial data, 
              providing the visual clarity you need to streamline decision-
              making, enhance safety, and maximize your project's efficiency.
            </p>
        </header>

        <!------------------- Repeatable Section Template ------------------->
        <section class="repeatable-section">

          <div 
            class="repeatable-section-inner"
          >
            <!-- Left Column -->
            <div class="two-columns-left">
              <h3>Your Job Site, Elevated</h3>
              <p>
                Our drone services empower construction companies to track 
                progress, optimize resources, enhance site safety, and achieve 
                significant cost savings. With clear, actionable aerial data, 
                your team stays informed, organized, and ahead of schedule.
              </p>
            </div>
            <!-- Right Column -->
            <div class="two-columns-right">
              <iframe
              width="100%"
              height="400"
              src="https://www.youtube.com/embed/mVCz41y0-7c?si=UHOOz2E7jqF86ag7"
              title="YouTube video player"
              frameborder="0"
              allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
              allowfullscreen
              class="iframe-video"
              loading="lazy"
            ></iframe>
            </div>
          </div>
        </section>

        <!------------------- Repeatable Section Template ------------------->
        <section class="repeatable-section">
          <div 
            class="repeatable-section-inner"
          >
            <!-- Left Column -->
            <div class="two-columns-left">
              <h3>Drone 3D Modeling</h3>
              <p>
                Transform your construction plans with precise, interactive 
                3D models. Our advanced drone technology overlays current 
                site progress with original blueprints, delivering accurate 
                volumetric measurements and detailed site analyses. Clearly 
                visualize your project from every angle, improving planning, 
                communication, and execution.
              </p>
            </div>
            <!-- Right Column -->
            <div class="media-stacked-column">
              <img
              src="/img/litchi_waypoint_mission.png"
              title="Litchi Waypoint Mission"
              class="landscape-image"
              loading="lazy"
            ></img>
              <iframe
                src="https://sketchfab.com/models/79336fac1adf431fb165942740755ec0/embed"
                title="Berkeley Commons South"
                frameborder="0"
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                allowfullscreen
                class="sketchfab-embed"
                loading="lazy"
              ></iframe>
            </div>
          </div>
        </section>

        <!------------------- Repeatable Section Template ------------------->
        <section class="repeatable-section">
          <div 
            class="repeatable-section-inner"
          >
            <!-- Left Column -->
            <div class="two-columns-left">
              <h3>Construction Progress Tracking</h3>
              <p>
                Stay consistently informed about your project's progress with 
                regular drone surveys. Weekly or monthly aerial imaging 
                provides clear updates, enabling effective timeline tracking, 
                budget management, and stakeholder communication. Strengthen 
                investor confidence and marketing efforts with compelling 
                visual documentation.
              </p>
            </div>
            <!-- Right Column -->
            <div class="media-stacked-column">
              <img
              src="/img/litchi_waypoint_mission.png"
              title="Litchi Waypoint Mission"
              class="landscape-image"
              loading="lazy"
            ></img>
              <iframe
                src="https://www.youtube.com/embed/mVCz41y0-7c?si=UHOOz2E7jqF86ag7"
                title="YouTube video player"
                frameborder="0"
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                allowfullscreen
                class="iframe-video"
                loading="lazy"
              ></iframe>
            </div>
          </div>
        </section>

        <!------------------- Repeatable Section Template ------------------->
        <section class="repeatable-section">
          <div 
            class="repeatable-section-inner"
          >
            <!-- Left Column -->
            <div class="two-columns-left">
              <h3>Comprehensive Drone Site Modeling</h3>
              <p>
                Document your construction journey from groundbreaking to 
                completion with detailed and accurate drone-generated site 
                models. Collaborating with licensed surveyors ensures 
                compliance, precision, and enhanced safety. Utilize these 
                models as robust marketing tools, strategic planning assets, 
                and to significantly reduce costs.
              </p>
            </div>
            <!-- Right Column -->
            <div class="two-columns-right">
                <iframe
                src="/qgis_webmap/index.html"
                title="Qgis Webmap"
                frameborder="0"
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                allowfullscreen
                class="iframe-video"
                loading="lazy"
              ></iframe>
            </div>
          </div>
        </section>

        <!------------------- Repeatable Section Template ------------------->
        <section class="repeatable-section">
          <div 
            class="repeatable-section-inner-one-column"
          >
            <!-- Left Column -->
            <div class="one-column">
              <h3>Real-Time Project Insights</h3>
              <p>
                Access immediate visibility into your project's status through 
                georeferenced orthophotos and interactive 3D datasets. 
                Facilitate virtual inspections, improve site management, and 
                transparently communicate progress. Effortlessly compare site 
                imagery across different project phases, clearly illustrating 
                your project's evolution.
              </p><br>
              <!-- Embedded Iframe (e.g., Before/After Slider) -->
              <iframe
                src="/before_after_slider/index.html"
                title="Before/After Slider"
                frameborder="0"
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                allowfullscreen
                class="w-full h-[400px] rounded-lg"
                loading="lazy"
              ></iframe>
            </div>
          </div>
        </section>
 
      </div>
    </div>
  </div>
</template>

<script setup>
// Importing the Three.js scene component
import ThreeGltf from '~/components/ThreeGltf.vue'
</script>

<style scoped>
/* Import custom fonts from Google Fonts */
@import url('https://fonts.googleapis.com/css2?family=Exo:wght@400;600;700&display=swap');

/* Apply the custom font to the body */
body {
  font-family: 'Exo', sans-serif;
}

/* Smooth transition effect for background opacity changes */
.relative {
  transition: background-opacity 0.3s ease;
}
</style>

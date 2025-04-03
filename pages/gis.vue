<template>
  <div class="relative min-h-screen bg-gray-900">
    <!-- Three.js Scene Component -->
    <!-- This component renders a Three.js scene as a fixed background layer covering the entire screen -->
    <ThreeTerrain class="fixed inset-0 w-full h-full z-0" />

    <!-- Contact Content Overlay -->
    <!-- Overlay container for the main content, positioned relative to the background -->
    <div class="relative flex flex-col items-center justify-start bg-black bg-opacity-0 pt-[62px]">
      <!-- Padding to avoid overlap with fixed header -->

      <!-- Main Content Wrapper -->
      <!-- Wrapper for the content sections with semi-transparent background -->
      <div class="header-fullwidth-container">
        <div class="header-section">
          <div class="header-section-inner">
            <div class="header-section-left">
              <h1>Geographic Information Systems</h1>
              <p>
                Unlock Powerful Geospatial Insights to Make Confident Decisions.
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
              <div id="headerRightCell">
                <!-- lil-gui panel is appended here from ThreeTerrain.vue -->
                <p class="text-gray-300">GUI Panel Will Appear Below:</p>
              </div>
            </div>
          </div>
        </div>
      </div>
      
      <!-- Additional Content Sections Wrapper -->
      <div class="content-section">

        <header class="header-container">
            <h2>Specialized GIS and geospatial 
              solutions for enhanced clarity and strategic results</h2>
              <p>
              Complex geospatial data requires clear interpretation to become 
              actionable insights.<br>
              <br>
              Expert Geographic Information Systems (GIS) solutions simplify 
              the process, delivering precise geospatial analyses and visually 
              compelling maps that clarify complex information and support 
              confident decision-making.
            </p>
        </header>

        <!------------------- Repeatable Section Template ------------------->
        <section class="repeatable-section">
          <div 
            class="repeatable-section-inner"
          >
            <!-- Left Column -->
            <div class="two-columns-left">
              <h3>Overlay Analysis</h3>
              <p>
                Transform raw GPS data into strategic insights through precise 
                overlay analysis. Clearly visualize spatial relationships, 
                environmental impacts, and geographic patterns. Overlay 
                analysis provides essential context for urban planning, 
                environmental conservation, and infrastructure projects, 
                ensuring that decisions are informed by accurate spatial 
                information.
              </p>
            </div>
            <!-- Right Column -->
            <div class="two-columns-right">
              <LightboxImage
                thumbSrc="/img/overlay_analysis_buffering_thumb.jpg" 
                highResSrc="/img/overlay_analysis_buffering_highres.jpg" 
                alt="Overlay Analysis Buffering" 
              />
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
              <h3>Geodatabase Design & Relationship 
                Management</h3>
              <p>
                Streamline data organization and enhance integrity by 
                designing structured, relational geodatabases tailored to 
                specific project requirements. Effective geodatabase design 
                simplifies data maintenance, supports accurate and efficient 
                analysis, and ensures seamless integration and sharing of 
                geographic information across teams and organizations.
              </p>
            </div>
            <!-- Right Column -->
            <div class="two-columns-right">
              <LightboxImage
                thumbSrc="/img/data_structure_and_relationships_thumb.jpg"
                highResSrc="/img/data_structure_and_relationships_highres.jpg"
                alt="Geodatabase Design & Relationship Management"
              />
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
              <h3>Digital Elevation Model (DEM) & <br>
                Surface Analysis</h3>
              <p>
                Gain deeper insights into terrain characteristics and 
                elevation features through advanced DEM and surface analysis 
                techniques. Detailed analysis of slopes, aspects, contours, 
                and hillshades enables precise risk assessment, informed 
                environmental planning, and optimized decision-making for 
                infrastructure development and land management.
              </p>
            </div>
            <!-- Right Column -->
            <div class="two-columns-right">
              <LightboxImage
                thumbSrc="/img/dem_surface_analysis_thumb.jpg"
                highResSrc="/img/dem_surface_analysis_highres.jpg"
                alt="Digital Elevation Model (DEM) and Surface Analysis"
              />
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
              <h3>Visibility & Site Optimization 
                Analysis</h3>
              <p>
                Ensure project success through sophisticated visibility 
                analyses and site optimization modeling. These services help 
                determine optimal placement of structures and infrastructure, 
                minimizing visual impact and environmental disturbances while 
                maximizing efficiency, safety, and strategic alignment with 
                project goals.
              </p>
            </div>
            <!-- Right Column -->
            <div class="two-columns-right">
              <LightboxImage
                thumbSrc="/img/viewshed_analysis_thumb.jpg"
                highResSrc="/img/viewshed_analysis_highres.jpg"
                alt="Viewshed Analysis and Visibility Modeling"
              />
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
              <h3>Site Selection & Suitability 
                Mapping</h3>
              <p>
                Leverage comprehensive raster-based analysis to identify 
                ideal locations for residential, commercial, or conservation 
                projects. By evaluating multiple criteria—including proximity 
                to critical infrastructure, environmental constraints, and 
                socio-economic factors—these detailed suitability maps 
                provide strategic guidance for informed, sustainable site 
                selection.
              </p>
            </div>
            <!-- Right Column -->
            <div class="two-columns-right">
              <LightboxImage
                thumbSrc="/img/raster_analysis_map_algebra_raster_overlay_for_site_selection_thumb.jpg"
                highResSrc="/img/raster_analysis_map_algebra_raster_overlay_for_site_selection_highres.jpg"
                alt="Raster Analysis and Site Suitability Mapping"
              />
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
              <h3>Geocoding & Precise Address Mapping
              </h3>
              <p>
                Convert address and tabular data into precise spatial visuals 
                through professional geocoding services. Enhance accuracy for 
                logistics planning, emergency response strategies, business 
                intelligence, and spatial data integration. Reliable geocoded 
                data improves operational effectiveness and decision-making 
                accuracy.
              </p>
            </div>
            <!-- Right Column -->
            <div class="two-columns-right">
              <LightboxImage
                thumbSrc="/img/geocoding_thumb.jpg"
                highResSrc="/img/geocoding_highres.jpg"
                alt="Geocoding and Address Mapping"
              />
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
              <h3>Network Analysis & Efficient Route 
                Planning</h3>
              <p>
                Optimize routes and improve logistics efficiency through 
                comprehensive network analysis and route planning services. 
                These advanced analyses factor in real-time road conditions, 
                closures, and travel restrictions to minimize costs, improve 
                response times, and support strategic operational planning 
                and resource management.
              </p>
            </div>
            <!-- Right Column -->
            <div class="two-columns-right">
              <LightboxImage
                thumbSrc="/img/network_analysis_thumb.jpg"
                highResSrc="/img/network_analysis_highres.jpg"
                alt="Network Analysis and Route Optimization"
              />
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
              <h3>Professional Map Creation</h3>
              <p>
                Produce visually compelling and professionally designed maps 
                tailored to effectively communicate complex geographic 
                information. From initial data integration and analysis to 
                detailed cartographic design and final delivery, map creation 
                services ensure clarity, precision, and impact in 
                presentations, reports, and online platforms. Expertly designed 
                maps enhance data storytelling, strategic planning, and 
                informed decision-making.
              </p>
            </div>
            <!-- Right Column -->
            <div class="two-columns-right">
              <LightboxImage
                thumbSrc="/img/map_creation_thumb.jpg"
                highResSrc="/img/map_creation_highres.jpg"
                alt="Map Creation"
              />
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

import LightboxImage from '~/components/LightboxImage.vue'
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

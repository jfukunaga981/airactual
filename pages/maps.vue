<template>
  <div class="relative min-h-screen bg-gray-900">
    <!-- Three.js Scene Component -->
    <!-- This component renders a Three.js scene as a fixed background layer covering the entire screen -->
    <ThreeMoon class="fixed inset-0 w-full h-full z-0" />

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
              <h1>Map Design and Visualization</h1>
              <p>
                Clear, Engaging Maps That Bring Your Data to Life
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
            <h2>Expert Map Design and GIS 
              Visualization to Enhance Understanding and 
              Decision-Making</h2>
            <p>
              Complex data can feel overwhelming without clear, visually 
              compelling presentation.<br>
              <br>
              Expert cartographic and Geographic Information Systems (GIS) 
              services simplify and visualize your data, making it 
              accessible, engaging, and actionable for confident, strategic 
              decisions.
            </p>
        </header>

        <!-- Repeatable Section Template -->
        <section class="repeatable-section">
          <div 
            class="repeatable-section-inner"
          >
            <!-- Left Column -->
            <div class="two-columns-left">
              <h3>Map Authoring & <br>
                Data Visualization</h3>
              <p>
                Craft professional, visually appealing maps by expertly 
                organizing, processing, and symbolizing spatial data. From 
                acquiring reliable datasets to optimizing attribute tables, 
                each step ensures clarity and ease of use for environmental, 
                urban planning, and ecotourism projects.
              </p>
            </div>
            <!-- Right Column -- modalWidth and modalHeight are specified -->
            <div class="two-columns-right">
              <LightboxImage
                thumbSrc="/img/new_zealand_mangroves_thumb.jpg"
                highResSrc="/img/new_zealand_mangroves_highres.jpg"
                alt="New Zealand Mangroves"
                modalWidth="800px"
                modalHeight="auto"
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
              <h3>Map Layout and Design</h3>
              <p>
                Design maps that tell compelling geographic stories through 
                carefully balanced layouts, strategic placement of elements, 
                and thematic symbology. Ideal for census mapping, cultural 
                studies, and thematic storytelling, these maps clearly 
                communicate complex narratives.
              </p>
            </div>
            <!-- Right Column -->
            <div class="two-columns-right">
              <LightboxImage
                thumbSrc="/img/languages_of_india_thumb.jpg"
                highResSrc="/img/languages_of_india_highres.jpg"
                alt="Languages of India"
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
              <h3>Map Projections & <br>Coordinate 
                Systems</h3>
              <p>
                Ensure spatial accuracy and clarity with expertly selected 
                map projections and coordinate systems. Special attention is 
                given to minimizing distortions for precise data 
                interpretation in global, regional, and specialized analyses, 
                such as climate change studies.
              </p>
            </div>
            <!-- Right Column -->
            <div class="two-columns-right">
              <LightboxImage
                thumbSrc="/img/map_projections_thumb.jpg"
                highResSrc="/img/map_projections_highres.jpg"
                alt="Map Projections and Coordinate Systems"
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
              <h3>Basemap Design & Thematic 
                Symbology</h3>
              <p>
                Create impactful maps by customizing basemaps and thematic 
                symbols, effectively highlighting critical spatial patterns. 
                Perfect for visualizing election results, demographics, and 
                conservation efforts, these maps clearly communicate 
                essential data.
              </p>
            </div>
            <!-- Right Column -->
            <div class="two-columns-right">
              <LightboxImage
                thumbSrc="/img/map_basics_thumb.jpg"
                highResSrc="/img/map_basics_highres.jpg"
                alt="Map Basics"
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
              <h3>Publishing & Sharing Web Maps</h3>
              <p>
                Make your maps accessible and interactive online, promoting 
                real-time collaboration and engagement through web maps and 
                cloud-based platforms. This service facilitates stakeholder 
                communication, public engagement, and informed internal 
                decision-making.
              </p>
            </div>
            <!-- Right Column -->
            <div class="two-columns-right">
              <LightboxImage
                thumbSrc="/img/publishing_and_sharing_web_maps_thumb.jpg"
                highResSrc="/img/publishing_and_sharing_web_maps_highres.jpg"
                alt="Publishing and Sharing Web Maps"
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
              <h3>Map Legends & <br>Advanced 
                Visualization</h3>
              <p>
                Elevate your maps with sophisticated legend design and 
                strategic visualization techniques, improving clarity and 
                user understanding. Essential for statistical visualization, 
                thematic maps, and complex data storytelling.
              </p>
            </div>
            <!-- Right Column -->
            <div class="two-columns-right">
              <LightboxImage
                thumbSrc="/img/map_legends_and_visualization_thumb.jpg"
                highResSrc="/img/map_legends_and_visualization_highres.jpg"
                alt="Map Legends and Visualization"
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
              <h3>Text as Symbology & Labeling</h3>
              <p>
                Enhance clarity and visual appeal through strategic use of 
                text, typography, and dynamic labeling. Ideal for thematic 
                maps, tourism guides, and urban planning, this service 
                ensures readability, precision, and engagement.
              </p>
            </div>
            <!-- Right Column -->
            <div class="two-columns-right">
              <LightboxImage
                thumbSrc="/img/text_as_symbology_and_labeling_thumb.jpg"
                highResSrc="/img/text_as_symbology_and_labeling_highres.jpg"
                alt="Text as Symbology and Labeling"
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
              <h3>Color & Symbology in <br>Thematic 
                Mapping</h3>
              <p>
                Clearly visualize complex demographic data through tailored 
                color schemes and thematic symbols, supporting social 
                analysis and sustainable development goals. Maps are expertly 
                designed to highlight patterns and relationships clearly.
              </p>
            </div>
            <!-- Right Column -->
            <div class="two-columns-right">
              <LightboxImage
                thumbSrc="/img/colors_and_symbology_thumb.jpg"
                highResSrc="/img/colors_and_symbology_highres.jpg"
                alt="Colors and Symbology"
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
              <h3>Multivariate Mapping & <br>Data 
                Uncertainty</h3>
              <p>
                Accurately visualize complex multivariate data and 
                communicate uncertainty through advanced mapping techniques. 
                Perfect for socio-economic studies, policy analysis, and 
                research requiring precise data representation.
              </p>
            </div>
            <!-- Right Column -->
            <div class="two-columns-right">
              <LightboxImage
                thumbSrc="/img/multivariate_mapping_of_the_world_happiness_report_thumb.jpg"
                highResSrc="/img/multivariate_mapping_of_the_world_happiness_report_highres.jpg"
                alt="Multivariate Mapping of the World Happiness Report"
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
              <h3>Aquifer & Water Resource Mapping</h3>
              <p>
                Analyze water resources and aquifer depletion through detailed 
                spatial assessments. Customized thematic mapping identifies 
                critical pressure points and supports sustainable management 
                practices for environmental protection and resource planning.
              </p>
            </div>
            <!-- Right Column -->
            <div class="two-columns-right">
              <LightboxImage
                thumbSrc="/img/geoprocessing_and_color_visualization_thumb.jpg"
                highResSrc="/img/geoprocessing_and_color_visualization_highres.jpg"
                alt="Geoprocessing and Color Visualization"
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
              <h3>Dot Density Mapping & Crime Analysis</h3>
              <p>
                Effectively illustrate crime trends and demographic 
                distributions using advanced dot density mapping techniques. 
                This approach clearly reveals patterns for informed resource 
                allocation, public safety, and urban planning strategies.
              </p>
            </div>
            <!-- Right Column -->
            <div class="two-columns-right">
              <LightboxImage
                thumbSrc="/img/texas_crime_dot_density_maps_thumb.jpg"
                highResSrc="/img/texas_crime_dot_density_maps_highres.jpg"
                alt="Texas Crime Dot Density Maps"
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
              <h3>Deforestation Analysis & Prediction
              </h3>
              <p>
                Predict and visualize environmental impacts of deforestation 
                using advanced spatial modeling. Ideal for conservation 
                planning, environmental assessments, and sustainable 
                development, these maps offer actionable insights and clear 
                visual communication.
              </p>
            </div>
            <!-- Right Column -->
            <div class="two-columns-right">
              <LightboxImage
                thumbSrc="/img/deforestation_in_rondonia_brazil_thumb.jpg"
                highResSrc="/img/deforestation_in_rondonia_brazil_highres.jpg"
                alt="Deforestatioin in Rondonia Brazil"
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

<template>
  <div class="relative min-h-screen bg-gray-900">
    <!-- Three.js Scene Component -->
    <!-- This component renders a Three.js scene as a fixed background layer covering the entire screen -->
    <ThreeSun class="fixed inset-0 w-full h-full z-0" />

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
              <h1>Contact us</h1>
              <p>
                Discover how we can elevate your project
              </p>
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

        <!-- Repeatable Section Template -->
        <section class="repeatable-section">
          <div 
            class="repeatable-section-inner"
          >
            <!-- Left Column -->
            <div class="two-columns-left">
              <h3>Get in touch!</h3>
              <p>
                Professionals across a wide range of industries rely on GIS 
                and drone services to transform complex spatial data into clear, 
                actionable insights. Whether you aim to visualize intricate 
                landscapes, enhance operational efficiency, or gain better 
                decision-making support, we’re here to help.<br><br>
                Reach out to discuss how our solutions can meet your unique needs.
              </p><br>
              <h3>Call Us</h3>
              <p>
                7 a.m.–5 p.m. (PT), Monday–Friday<br>
                <a href="tel:+19252898382" class="text-blue-400 hover:underline">+1-925-289-8382</a><br><br>
              </p>
              <h3>Email Us</h3>
              <p>
                Inquiries by email<br>
                <a href="mailto:jeremy@airactual.com?subject=Inquiry" class="text-blue-400 hover:underline break-all">info@airactual.com</a>
              </p>
            </div>
            <!-- Right Column -->
            <div class="two-columns-right">
              <img
                src="/img/bay_area_vector-01.png"
                alt="Geodatabase Design & Relationship Management"
                class="landscape-image"
                loading="lazy"
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
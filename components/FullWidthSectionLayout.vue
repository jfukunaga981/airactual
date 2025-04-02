<template>
  <div class="relative min-h-screen bg-gray-900">
    <!-- Background Scene Component Slot -->
    <slot name="background">
      <ThreeGltf class="fixed inset-0 w-full h-full z-0" />
    </slot>

    <!-- Main Content Overlay -->
    <div class="relative flex flex-col items-center justify-start bg-black bg-opacity-0 pt-20 w-full">
      <!-- Full-width section wrapper -->
      <div class="w-full bg-black bg-opacity-50">
        <!-- Content Container with Max Width -->
        <div class="max-w-5xl mx-auto bg-black bg-opacity-0 p-8 rounded-lg w-full mb-48">
          <!-- Content Slot for Page-specific Content -->
          <slot name="section1">
            <section class="grid grid-cols-1 md:grid-cols-2 gap-8">
              <div class="flex flex-col justify-center p-6">
                <h1 class="text-4xl font-exo mb-4 italic text-white">MY CUSTOM SECTION</h1>
                <p class="text-gray-100">
                  This section contains content unique to this page but inherits the layout from the template.                </p>
                <div class="mt-5">
                  <NuxtLink
                    to="/work"
                    class="text-white bg-gnomon-blue inline-block px-8 py-4 rounded-full font-lato hover:bg-blue-700 transition"
                  >
                    Learn More
                  </NuxtLink>
                </div>
              </div>
              <div class="flex items-center justify-center pointer-events-auto">
                <!-- Placeholder for optional image or custom content -->
              </div>
            </section>
          </slot>
        </div>
      </div>

      <!-- Additional Content Section Slots -->
      <slot name="additional-sections">
        <!-- Default layout for additional sections -->
        <div class="w-full bg-black bg-opacity-0 p-8 max-w-5xl mx-auto rounded-lg mb-48">
          <section class="grid grid-cols-1 md:grid-cols-2 gap-8 rounded-lg bg-black bg-opacity-50 p-10">
            <div class="flex flex-col justify-center p-6">
              <h3 class="text-2xl font-semibold mb-3 text-white">Custom Section</h3>
              <p class="text-gray-200">This is an example of a reusable content section.</p>
            </div>
            <div class="flex items-center justify-center pointer-events-auto">
              <!-- Placeholder for additional content -->
              <h3 class="text-2xl font-semibold mb-3 text-white">Custom Section</h3>
              <p class="text-gray-200">This is an example of a reusable content section.</p>
            </div>
          </section>
        </div>
      </slot>

      <!-- Additional Content Section Slots -->
      <slot name="additional-sections">
        <!-- Default layout for additional sections -->
        <div class="w-full bg-black bg-opacity-0 p-8 max-w-5xl mx-auto rounded-lg mb-48">
          <section class="grid grid-cols-1 md:grid-cols-2 gap-8 rounded-lg bg-black bg-opacity-50 p-10">
            <div class="flex flex-col justify-center p-6">
              <h3 class="text-2xl font-semibold mb-3 text-white">Custom Section</h3>
              <p class="text-gray-200">This is an example of a reusable content section.</p>
            </div>
            <div class="flex items-center justify-center pointer-events-auto">
              <!-- Placeholder for additional content -->
            </div>
          </section>
        </div>
      </slot>
    </div>
  </div>
</template>

<script setup>
import ThreeGltf from '~/components/ThreeGltf.vue'
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Exo:wght@400;600;700&display=swap');

body {
  font-family: 'Exo', sans-serif;
}

.relative {
  transition: background-opacity 0.3s ease;
}
</style>
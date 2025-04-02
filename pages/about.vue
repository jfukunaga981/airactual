<template>
  <div class="relative h-screen overflow-hidden bg-gray-900">
    <!-- Three.js Scene Component -->
    <ThreeContact class="absolute inset-0 w-full h-full" />

    <!-- Contact Content Overlay -->
    <div class="absolute inset-0 flex items-center justify-center bg-black bg-opacity-0">
      <div class="bg-black bg-opacity-90 p-8 rounded-lg shadow-xl max-w-3xl w-full mx-4 border border-neutral-500">
        <header class="text-center mb-8">
          <h1 class="text-4xl font-exo mb-4 italic text-neutral-100">CONTACT US</h1>
          <p class="text-neutral-100">
            Reach out by phone, text, or email. We're standing by to help you with service inquiries, customer service, or just general questions.
          </p>
        </header>
        <section class="grid grid-cols-1 md:grid-cols-2 gap-8">
          <!-- First Column -->
          <div class="flex flex-col justify-center p-6 rounded-lg bg-black bg-opacity-50 transition transform hover:scale-105">
            <h3 class="text-2xl font-semibold mb-3 text-white">Call Us</h3>
            <p class="text-gray-200">
              7 a.m.–5 p.m. (PT), Monday–Friday<br>
              <a href="tel:+19252898382" class="text-blue-400 hover:underline">+1-925-289-8382</a>
            </p>
          </div>
          <!-- Second Column -->
          <div class="flex flex-col justify-center p-6 rounded-lg bg-black bg-opacity-50 transition transform hover:scale-105">
            <h3 class="text-2xl font-semibold mb-3 text-white">Email Us</h3>
            <p class="text-gray-200 break-words">
              Inquiries by email<br>
              <a href="mailto:jeremy@airactual.com?subject=Inquiry" class="text-blue-400 hover:underline break-all">jeremy@airactual.com</a>
            </p>
          </div>
        </section>
      </div>
    </div>
  </div>
</template>

<script setup>
import ThreeContact from '~/components/ThreeContact.vue'
</script>

<style scoped>
/* Custom Font (if not already included) */
@import url('https://fonts.googleapis.com/css2?family=Exo:wght@400;600;700&display=swap');

body {
  font-family: 'Exo', sans-serif;
}

/* Optional: Add smooth transition for background overlay */
.absolute.inset-0 {
  transition: background-opacity 0.3s ease;
}
</style>

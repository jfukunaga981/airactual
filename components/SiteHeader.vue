<template>
  <nav class="fixed top-0 left-0 w-full bg-gray-800 p-4 z-10 shadow-md">
    <div class="container mx-auto flex items-center justify-between">
      <!-- Logo / Site Title -->
      <div class="text-white text-xl font-exo">
        <NuxtLink to="/" class="text-white font-bold tracking-wide hover:text-blue-400">Air Actual</NuxtLink>
      </div>

      <!-- Desktop Menu -->
      <div class="hidden md:flex space-x-4">
        <NuxtLink to="/" class="text-gray-300 hover:text-white">Home</NuxtLink>
        <NuxtLink to="/gis" class="text-gray-300 hover:text-white">GIS</NuxtLink>
        <NuxtLink to="/maps" class="text-gray-300 hover:text-white">Maps</NuxtLink>
        <NuxtLink to="/construction" class="text-gray-300 hover:text-white">Construction</NuxtLink>
        <NuxtLink to="/contact" class="text-gray-300 hover:text-white">Contact</NuxtLink>
      </div>

      <!-- Mobile Menu Button -->
      <div class="md:hidden">
        <button @click="toggleMenu" class="text-gray-300 hover:text-white focus:outline-none">
          <svg class="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path
              v-if="!isMenuOpen"
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M4 6h16M4 12h16M4 18h16"
            />
            <path
              v-else
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M6 18L18 6M6 6l12 12"
            />
          </svg>
        </button>
      </div>
    </div>

    <!-- Mobile Menu -->
    <div v-if="isMenuOpen" class="md:hidden">
      <NuxtLink
        to="/"
        class="block px-4 py-2 text-gray-300 hover:text-white"
        @click="closeMenu"
      >
        Home
      </NuxtLink>
      <NuxtLink
        to="/gis"
        class="block px-4 py-2 text-gray-300 hover:text-white"
        @click="closeMenu"
      >
        GIS
      </NuxtLink>
      <NuxtLink
        to="/maps"
        class="block px-4 py-2 text-gray-300 hover:text-white"
        @click="closeMenu"
      >
        Maps
      </NuxtLink>
      <NuxtLink
        to="/construction"
        class="block px-4 py-2 text-gray-300 hover:text-white"
        @click="closeMenu"
      >
        Construction
      </NuxtLink>
      <NuxtLink
        to="/contact"
        class="block px-4 py-2 text-gray-300 hover:text-white"
        @click="closeMenu"
      >
        Contact
      </NuxtLink>
    </div>
  </nav>
</template>

<script setup>
import { ref } from 'vue'

const isMenuOpen = ref(false)

function toggleMenu() {
  isMenuOpen.value = !isMenuOpen.value
}

function closeMenu() {
  isMenuOpen.value = false
}
</script>

<style scoped>
/* Add any additional styling here if needed */
</style>

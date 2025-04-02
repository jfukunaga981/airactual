<template>
  <div class="flex flex-col min-h-screen">
    <SiteHeader />
    <main>
      <slot />
    </main>
    <SiteFooter />
  </div>
</template>

<script setup>
import SiteHeader from '~/components/SiteHeader.vue'
import SiteFooter from '~/components/SiteFooter.vue'
</script>

<style scoped>
/* Add any additional styling here */
</style>

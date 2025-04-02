<template>
  <div>
    <!-- Clickable Thumbnail Image with Tailwind rounded class -->
    <img
      :src="thumbSrc"
      :alt="alt"
      class="cursor-pointer rounded-lg"
      loading="lazy"
      @click="openModal"
    />

    <!-- Modal Overlay styled with Tailwind -->
    <div
      v-if="showModal"
      class="fixed inset-0 bg-black bg-opacity-80 flex justify-center items-center z-50"
    >
      <div class="relative bg-white p-0 border-8 border-white rounded shadow-lg">
        <!-- Close Button -->
        <button
          class="absolute bottom-[-50px] right-[-2px] text-white text-5xl"
          @click="closeModal"
        >
          𐄂
        </button>
        <!-- High Resolution Image -->
        <!-- Instead of fixed Tailwind classes for sizing, we use dynamic styles bound to modalWidth and modalHeight props -->
        <img
          :src="highResSrc"
          :alt="alt"
          class="block"
          :style="{ maxWidth: modalWidth, maxHeight: modalHeight }"
        />
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

// Extend the props to include modalWidth and modalHeight for dynamic sizing
const props = defineProps({
  thumbSrc: {
    type: String,
    required: true
  },
  highResSrc: {
    type: String,
    required: true
  },
  alt: {
    type: String,
    default: 'Image'
  },
  // New prop: modalWidth allows you to set the maximum width of the modal image (default: 90vw)
  modalWidth: {
    type: String,
    default: '800px'
  },
  // New prop: modalHeight allows you to set the maximum height of the modal image (default: 90vh)
  modalHeight: {
    type: String,
    default: '800px'
  }
})

// Control the visibility of the modal
const showModal = ref(false)

// Open the modal when the thumbnail is clicked
const openModal = () => {
  showModal.value = true
}

// Close the modal when the close button is clicked
const closeModal = () => {
  showModal.value = false
}
</script>

<style scoped>
/* Existing custom styles remain available if needed */
.lightbox-thumb {
  cursor: pointer;
  /* Add any additional thumbnail styling here */
}

.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.8);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
}

.modal-content {
  position: relative;
  background: #fff;
  padding: 1rem;
  border: 8px solid #ddd;
  border-radius: 8px;
  box-shadow: 0 0 15px rgba(0, 0, 0, 0.5);
}

.close-button {
  position: absolute;
  top: 10px;
  right: 10px;
  background: none;
  border: none;
  color: #000;
  font-size: 2rem;
  cursor: pointer;
}

.modal-image {
  max-width: 90vw;
  max-height: 90vh;
  display: block;
}
</style>

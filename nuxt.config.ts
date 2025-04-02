import vitePluginString from 'vite-plugin-string'
import glsl from 'vite-plugin-glsl'

// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  css: [
    '~/assets/css/tailwind.css',
    '~/assets/css/global.css',
  ],

  postcss: {
    plugins: {
      tailwindcss: {},
      autoprefixer: {},
    },
  },

  app: {
    head: {
      link: [
        { rel: 'preconnect', href: 'https://fonts.gstatic.com' },
        {
          rel: 'stylesheet',
          href: 'https://fonts.googleapis.com/css2?family=Exo+2:ital,wght@1,700&family=Lato&display=swap',
        },
      ],
    },
  },

  vite: {
    plugins: [
      vitePluginString(),
      [glsl()]  // Add GLSL plugin to Vite
    ],
  },

  compatibilityDate: '2024-11-23',
})
const defaultTheme = require('tailwindcss/defaultTheme')
console.log('ALOOO TAILWIND')
module.exports = {
  content: [
    "./app/views/**/*.html.erb",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/javascript/**/*.jsx",
    "./app/javascript/**/*.vue",
    "./app/assets/stylesheets/**/*.css"
  ],
  theme: {
    extend: {
      colors: {
        customBlue: "#1E40AF",
        customRed: "#E63946"
      }
    },
  },
  plugins: [],
};

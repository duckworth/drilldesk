import { applyDarkMode, toggleDarkMode, THEME_KEY } from "./dark_mode_lib";

var themeToggleDarkIcon = document.getElementById("theme-toggle-dark-icon");
var themeToggleLightIcon = document.getElementById("theme-toggle-light-icon");
var themeToggleBtn = document.getElementById("theme-toggle");

// Change the icons inside the button based on previous settings
if (
  localStorage.getItem(THEME_KEY) === "dark" ||
  (!localStorage.getItem(THEME_KEY) && window.matchMedia("(prefers-color-scheme: dark)").matches)
) {
  themeToggleLightIcon?.classList.remove("hidden");
} else {
  themeToggleDarkIcon?.classList.remove("hidden");
}

// Add click event listener to toggle dark mode
if (themeToggleBtn) {
themeToggleBtn.addEventListener("click", () => {
  // Toggle icons
    themeToggleDarkIcon?.classList.toggle("hidden");
    themeToggleLightIcon?.classList.toggle("hidden");

  // Call the shared toggle logic
  toggleDarkMode();
});
}

// Apply dark mode on page load
document.addEventListener("DOMContentLoaded", applyDarkMode);
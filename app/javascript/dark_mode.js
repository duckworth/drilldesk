import { applyDarkMode, toggleDarkMode, THEME_KEY } from "./dark_mode_lib";

// We will initialize these variables inside the event handler:
let themeToggleDarkIcon, themeToggleLightIcon, themeToggleBtn;

// Run whenever Turbo renders or loads a new page
document.addEventListener("turbo:load", () => {
  // Apply the correct mode based on localStorage or prefers-color-scheme
  applyDarkMode();

  // Grab your elements again (they may be replaced by Turbo)
  themeToggleDarkIcon = document.getElementById("theme-toggle-dark-icon");
  themeToggleLightIcon = document.getElementById("theme-toggle-light-icon");
  themeToggleBtn = document.getElementById("theme-toggle");

  // Reset the icons’ visibility
  if (
    localStorage.getItem(THEME_KEY) === "dark" ||
    (
      !localStorage.getItem(THEME_KEY) &&
      window.matchMedia("(prefers-color-scheme: dark)").matches
    )
  ) {
    themeToggleLightIcon?.classList.remove("hidden");
    themeToggleDarkIcon?.classList.add("hidden");
  } else {
    themeToggleDarkIcon?.classList.remove("hidden");
    themeToggleLightIcon?.classList.add("hidden");
  }

  // Re-attach the click listener to the toggle button
  if (themeToggleBtn) {
    themeToggleBtn.addEventListener("click", () => {
      // Toggle the icons
      themeToggleDarkIcon?.classList.toggle("hidden");
      themeToggleLightIcon?.classList.toggle("hidden");

      // Actually toggle dark mode in localStorage and documentElement
      toggleDarkMode();
    });
  }
});

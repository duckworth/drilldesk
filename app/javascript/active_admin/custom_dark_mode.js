import { applyDarkMode, toggleDarkMode } from "../dark_mode_lib";

document.addEventListener("DOMContentLoaded", () => {
  // Apply dark mode on page load
  applyDarkMode();

  // Attach event listener to the Active Admin dark mode toggle button
  const themeToggleBtn = document.querySelector(".dark-mode-toggle");
  if (themeToggleBtn) {
    themeToggleBtn.addEventListener("click", toggleDarkMode);
  }
});

// Sync changes made externally (e.g., via local storage in another tab or component)
window.addEventListener("storage", (event) => {
  if (event.key === "color-theme") {
    applyDarkMode();
  }
});
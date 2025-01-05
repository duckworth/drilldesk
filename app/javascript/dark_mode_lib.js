// shared_dark_mode.js
export const THEME_KEY = "color-theme";
const darkModeMedia = window.matchMedia("(prefers-color-scheme: dark)");

export const applyDarkMode = () => {
  if (
    localStorage.getItem(THEME_KEY) === "dark" ||
    (!(THEME_KEY in localStorage) && darkModeMedia.matches)
  ) {
    document.documentElement.classList.add("dark");
  } else {
    document.documentElement.classList.remove("dark");
  }
};

export const toggleDarkMode = () => {
  if (
    localStorage.getItem(THEME_KEY) === "dark" ||
    (!(THEME_KEY in localStorage) && darkModeMedia.matches)
  ) {
    document.documentElement.classList.remove("dark");
    localStorage.setItem(THEME_KEY, "light");
  } else {
    document.documentElement.classList.add("dark");
    localStorage.setItem(THEME_KEY, "dark");
  }
};
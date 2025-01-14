import {Controller} from "@hotwired/stimulus";
import {showToast} from "../utils/toast";

export default class extends Controller {
  // static targets = ["container"];

  connect() {
    this.setupGlobalErrorHandler();
  }

  setupGlobalErrorHandler() {
    document.addEventListener("turbo:fetch-request-error", this.handleFetchError.bind(this));
  }

  handleFetchError(event) {
    const {error} = event.detail;
    console.error("Fetch request failed:", error);
    showToast("The server is currently unavailable. Please try again later.", "error");
  }
}

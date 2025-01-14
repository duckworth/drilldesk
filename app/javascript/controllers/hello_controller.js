import { Controller } from "@hotwired/stimulus"
import {showToast} from "../utils/toast";
export default class extends Controller {
  connect() {
    this.element.onclick = () => {
      const message = this.element.dataset.helloMessage; // "Custom message from HTML"
      const type = this.element.dataset.helloType; // "success"
      showToast(message, type, 10000);
    }
  }
}

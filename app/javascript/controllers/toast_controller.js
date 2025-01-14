import { Controller } from "@hotwired/stimulus"
import { showToast } from "../utils/toast"

export default class extends Controller {
  static values = { message: String, type: { type: String, default: "success" }, duration: { type: Number, default: 5000 } }

  connect() {
    this.show() // Automatically show toast when the controller is connected
  }

  show() {
    showToast(this.messageValue, this.typeValue, this.durationValue)
  }
}
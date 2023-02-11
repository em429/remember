import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  connect() {
    this.element.style.animation = "appear_then_fade 4s both"
    setTimeout(() => { this.element.remove() }, 4000)
  }
}

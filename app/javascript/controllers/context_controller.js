import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="context"
export default class extends Controller {
  static targets = [ "excerpt" ]
  static values = { index: Number }

  initialize() {
    this.showCurrentExcerpt()
  }

  more() {
    this.indexValue++
    this.showCurrentExcerpt()
  }

  less() {
    this.indexValue--
    this.showCurrentExcerpt()
  }

  showCurrentExcerpt() {
    this.excerptTargets.forEach((element, index) => {
      element.hidden = index !== this.indexValue
    })
  }

}

import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="context"
export default class extends Controller {
  static targets = [ "excerpt", "more_button", "less_button" ]
  static values = { index: Number }

  initialize() {
    this.showCurrentExcerpt()
  }

  show_more() {
    this.indexValue++
    this.showCurrentExcerpt()
  }

  show_less() {
    this.indexValue--
    this.showCurrentExcerpt()
  }

  showCurrentExcerpt() {
    this.excerptTargets.forEach((element, index) => {
      element.hidden = index !== this.indexValue

      // FIXME: this is a bit hacky, as it requires to match the number of allowed context increases
      // in two places: here and in the _full_card partial.

      // Hide the less and more buttons if we run out of context objects
      this.more_buttonTarget.hidden = this.indexValue == 2
      this.less_buttonTarget.hidden = this.indexValue == 0

    })

  }

}

import Reveal from 'stimulus-reveal-controller'

export default class extends Reveal {
  // Add an extra 'button' target so we can hide it later
  //   'item' is default target from parent Reveal class
  static targets = ['item', 'button']
  show() {
    // We just simply call the parent class's toggle for now
    super.show()

    // Hide the 'more context' button
    this.buttonTarget.classList.toggle(this.class)
  }

  show_button() {
    this.buttonTarget.classList.remove(this.class)
  }

}

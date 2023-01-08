import Reveal from 'stimulus-reveal-controller'

export default class extends Reveal {
  toggle() {
    // We just simply call the parent class's toggle for now
    super.toggle()
    // Add anythinge extra here
  }

  // Show only the first paragrpah
  show_first() {
    this.itemTarget.classList.toggle(this.class)
  }
}

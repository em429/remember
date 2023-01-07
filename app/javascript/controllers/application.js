import { Application } from "@hotwired/stimulus"

// Import extra stimulus-components, pinned using the importmap command
import Reveal from 'stimulus-reveal-controller'

const application = Application.start()

// Register extra stimulus-components
application.register('reveal', Reveal)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

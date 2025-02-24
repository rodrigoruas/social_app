import { Controller } from "@hotwired/stimulus";
import { enter, leave } from 'el-transition';

export default class extends Controller {
  static targets = ["mobileMenu", "mobileIconOpened", "mobileIconClosed"]

  connect() {
    console.log("Hello from navbar_menu_controller.js")
    console.log(this.mobileMenuTarget)
    console.log(this.mobileIconOpenedTarget)
    console.log(this.mobileIconClosedTarget)
  }

  toggleMobileMenu() {
    console.log("toggleMobileMenu")
    if (this.mobileMenuTarget.dataset.state === "closed") {
      this.mobileMenuTarget.dataset.state = "opened"
      enter(this.mobileMenuTarget)
      this.mobileIconOpenedTarget.classList.remove('hidden')
      this.mobileIconClosedTarget.classList.add('hidden')
    } else {
      this.mobileMenuTarget.dataset.state = "closed"
      leave(this.mobileMenuTarget)
      this.mobileIconOpenedTarget.classList.add('hidden')
      this.mobileIconClosedTarget.classList.remove('hidden')
    }
  }
}

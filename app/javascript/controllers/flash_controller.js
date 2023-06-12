import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  initialize() {
    const toast = this.element.querySelector('.alerts');
    new bootstrap.Toast(toast, {delay: 100000}).show();
  }

  close () {
    setTimeout(() => this.element.remove(), 1000)
  }
}
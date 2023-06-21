# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "https://ga.jspm.io/npm:@hotwired/stimulus@3.2.1/dist/stimulus.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "stimulus-character-counter", to: "https://ga.jspm.io/npm:stimulus-character-counter@4.2.0/dist/stimulus-character-counter.mjs"
pin "stimulus-lightbox", to: "https://ga.jspm.io/npm:stimulus-lightbox@3.2.0/dist/stimulus-lightbox.mjs"
pin "lightgallery", to: "https://ga.jspm.io/npm:lightgallery@2.7.1/lightgallery.es5.js"

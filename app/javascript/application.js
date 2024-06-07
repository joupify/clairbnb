// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "@popperjs/core"
import "bootstrap"

import { createConsumer } from "@rails/actioncable"

const consumer = createConsumer()



// app/javascript/application.js
import * as ActionCable from "@rails/actioncable"

window.Turbo = Turbo
window.ActionCable = ActionCable
import "channels"



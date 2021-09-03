// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require_tree .
//= require jquery
//= require metrics-graphics-rails

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import * as metric from 'metrics-graphics'

import "channels"
import "../src/home"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

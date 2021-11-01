import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require activestorage


Rails.start()
Turbolinks.start()
ActiveStorage.start()

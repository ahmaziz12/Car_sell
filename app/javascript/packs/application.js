require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")
import $ from 'jquery';
global.$ = jQuery;
require("trix")
require("@rails/actiontext")
import 'bootstrap';
require("../ads")
import ActiveStorageDragAndDrop from 'active_storage_drag_and_drop'
ActiveStorageDragAndDrop.start()

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
  }
  open_edit_issue_modal(e) {
    $('#edit_issue').show();
  }
  close_edit_issue_modal(e) {
    $('#edit_issue').hide();
  }
  open_edit_suggestion_modal(e) {
    $('#edit_suggestion').show();
  }
  close_edit_suggestion_modal(e) {
    $('#edit_suggestion').hide();
  }
}

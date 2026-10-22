const init = function() {
  var buttons = document.querySelectorAll("[data-batch-action-option='button']");
  var checkboxes = document.querySelectorAll("[data-batch-action-option='checkbox']");
  var selectAllCheckboxes = document.querySelector("[data-batch-action-option='select_all']");

  if (selectAllCheckboxes && checkboxes && buttons) {

    window.onpageshow = function(event) {
      if (selectedIds().length > 0) {
        checkboxes.forEach(function(checkbox) {
          checkbox.checked = false;
        });

        selectAllCheckboxes.checked = false;
      }
    };

    selectAllCheckboxes.addEventListener('click', function(){
      checkboxes.forEach(function(checkbox) {
        checkbox.checked = selectAllCheckboxes.checked;
      });

      checkAndToggleActionButtons();
    });

    buttons.forEach(function(button){
      var originalHref = button.getAttribute('href');

      button.addEventListener('click', function(event){
        // Rebuild from the original href so existing query params are kept
        // and repeated clicks (e.g. a cancelled confirm) don't append twice.
        var url = new URL(originalHref, window.location.href);

        selectedIds().forEach(function(id) {
          url.searchParams.append('batch_action_ids[]', id);
        });

        button.href = url.toString();
      });
    });

    checkboxes.forEach(function(checkbox){
      checkbox.closest('td').addEventListener('click', function(event){
        event.stopImmediatePropagation();
      })

      checkbox.addEventListener('click', function(event) {
        event.stopImmediatePropagation();

        checkAndToggleActionButtons();
      })
    })
  }

  function selectedIds() {
    return Array.prototype.filter.call(checkboxes, function(checkbox) {
      return checkbox.checked;
    }).map(function(checkbox) {
      return checkbox.value;
    });
  }

  function checkAndToggleActionButtons() {
    if (selectedIds().length > 0) {
      buttons.forEach(function(button){
        button.classList.remove('disabled');
        button.removeAttribute('disabled');
      });
    } else {
      buttons.forEach(function(button){
        button.classList.add('disabled');
        button.setAttribute('disabled', 'disabled');
      });
    }
  }
};

document.addEventListener("DOMContentLoaded", function() { init() });
document.addEventListener("turbolinks:load", function() { init() });
document.addEventListener("turbo:load", function() { init() });

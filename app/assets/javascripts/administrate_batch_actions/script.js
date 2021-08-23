var buttons = document.querySelectorAll("[data-batch-action-option='button']");
var checkboxes = document.querySelectorAll("[data-batch-action-option='checkbox']");
var selectAllCheckboxes = document.querySelector("[data-batch-action-option='select_all']");

if (selectAllCheckboxes && checkboxes && buttons) {
  selectAllCheckboxes.addEventListener('click', function(){
    checkboxes.forEach(function(checkbox) {
      checkbox.checked = selectAllCheckboxes.checked;
    });

    checkAndToggleActionButtons();
  });

  buttons.forEach(function(button){
    button.addEventListener('click', function(event){
      button.href += '?' + selectedItemIds()
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

function selectedItemIds() {
  var ids = Array.prototype.filter.call(checkboxes, function(checkbox) {
        if (checkbox.checked) { return checkbox }
      }).map(function(checkbox) {
        return 'batch_action_ids[]=' + checkbox.value
      }).join('&');
  return ids;
}

function checkAndToggleActionButtons() {
  if (selectedItemIds()) {
    buttons.forEach(function(button){
      button.classList.remove('disabled');
    });
  } else {
    buttons.forEach(function(button){
      button.classList.add('disabled');
    });
  }
}

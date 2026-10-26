(function () {
  const boundForms = new WeakSet();
  const boundCheckboxes = new WeakSet();
  const boundSelectAllCheckboxes = new WeakSet();

  const init = function () {
    var buttons = document.querySelectorAll(
      "[data-batch-action-option='button']",
    );
    var checkboxes = document.querySelectorAll(
      "[data-batch-action-option='checkbox']",
    );
    var selectAllCheckboxes = document.querySelector(
      "[data-batch-action-option='select_all']",
    );

    if (selectAllCheckboxes && checkboxes && buttons) {
      // Reset selections restored by the browser's back/forward cache
      window.onpageshow = function (event) {
        if (selectedItemIds().length > 0) {
          checkboxes.forEach(function (checkbox) {
            checkbox.checked = false;
          });

          selectAllCheckboxes.checked = false;
        }

        checkAndToggleActionButtons();
      };

      if (!isBoundElement(boundSelectAllCheckboxes, selectAllCheckboxes)) {
        boundSelectAllCheckboxes.add(selectAllCheckboxes);

        selectAllCheckboxes.addEventListener("click", function () {
          checkboxes.forEach(function (checkbox) {
            checkbox.checked = selectAllCheckboxes.checked;
          });

          checkAndToggleActionButtons();
        });
      }

      buttons.forEach(function (button) {
        var form = button.form;
        if (!form || isBoundElement(boundForms, form)) return;
        boundForms.add(form);

        form.addEventListener("submit", function (event) {
          var confirmMessage = button.dataset.batchActionConfirm;

          if (confirmMessage && confirm(confirmMessage) !== true) {
            event.preventDefault();
            return;
          }

          // Replace ids from a previous submission (e.g. after navigating back)
          form
            .querySelectorAll("[data-batch-action-option='hidden_id']")
            .forEach(function (hiddenInput) {
              hiddenInput.remove();
            });

          selectedItemIds().forEach(function (id) {
            var hiddenInput = document.createElement("input");
            hiddenInput.type = "hidden";
            hiddenInput.name = "batch_action_ids[]";
            hiddenInput.value = id;
            hiddenInput.dataset.batchActionOption = "hidden_id";
            form.appendChild(hiddenInput);
          });
        });
      });

      checkboxes.forEach(function (checkbox) {
        if (isBoundElement(boundCheckboxes, checkbox)) {
          return;
        }
        boundCheckboxes.add(checkbox);

        checkbox.closest("td").addEventListener("click", function (event) {
          event.stopImmediatePropagation();
        });

        checkbox.addEventListener("click", function (event) {
          event.stopImmediatePropagation();

          checkAndToggleActionButtons();
        });
      });
    }

    function selectedItemIds() {
      return Array.prototype.filter
        .call(checkboxes, function (checkbox) {
          return checkbox.checked;
        })
        .map(function (checkbox) {
          return checkbox.value;
        });
    }

    function checkAndToggleActionButtons() {
      var disabled = selectedItemIds().length === 0;

      buttons.forEach(function (button) {
        button.disabled = disabled;
      });
    }

    function isBoundElement(boundElement, incomingElement) {
      return boundElement.has(incomingElement);
    }
  };

  document.addEventListener("DOMContentLoaded", function () {
    init();
  });
  document.addEventListener("turbolinks:load", function () {
    init();
  });
  document.addEventListener("turbo:load", function () {
    init();
  });
})();

const boundForms = new WeakSet();
const boundCheckboxes = new WeakSet();
const boundSelectAllCheckboxes = new WeakSet();

const init = function () {
  var buttons = document.querySelectorAll(
    "[data-batch-action-option='button']",
  );
  const forms = document.querySelectorAll(
    "form:has([data-batch-action-option='button'])",
  );
  var checkboxes = document.querySelectorAll(
    "[data-batch-action-option='checkbox']",
  );
  var selectAllCheckboxes = document.querySelector(
    "[data-batch-action-option='select_all']",
  );

  if (selectAllCheckboxes && checkboxes && buttons) {
    window.onpageshow = function (event) {
      if (selectedItemIds() && selectedItemIds().length === 0) {
        checkboxes.forEach(function (checkbox) {
          checkbox.checked = false;
        });

        selectAllCheckboxes.checked = false;
      }
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

    forms.forEach(function (form) {
      if (isBoundElement(boundForms, form)) return;
      boundForms.add(form);

      const confirmMessage =
        form.querySelector("[data-confirm]")?.dataset?.confirm ||
        "Are you sure you want to submit this form?";

      form.addEventListener("submit", function (event) {
        event.preventDefault();

        if (confirm(confirmMessage) === true) {
          selectedItemIds().forEach(function (id) {
            const hiddenInput = document.createElement("input");
            hiddenInput.type = "hidden";
            hiddenInput.name = "batch_action_ids[]";
            hiddenInput.value = id;
            form.appendChild(hiddenInput);
          });
          form.submit();
        } else {
          return;
        }
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
    var ids = Array.prototype.filter
      .call(checkboxes, function (checkbox) {
        if (checkbox.checked) {
          return checkbox;
        }
      })
      .map(function (checkbox) {
        return checkbox.value;
      });
    return ids;
  }

  function checkAndToggleActionButtons() {
    if (selectedItemIds() && selectedItemIds().length > 0) {
      buttons.forEach(function (button) {
        button.disabled = false;
      });
    } else {
      buttons.forEach(function (button) {
        button.disabled = true;
      });
    }
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

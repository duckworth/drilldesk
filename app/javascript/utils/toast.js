import Toastify from 'toastify-js';

// types: success, error, warning
export function showToast(message, type = "success", duration = 5000) {
  console.log("Showing toast");

  const toastContent = document.createElement('div');
  toastContent.innerHTML = `
    <div class="toast-base toast-base-${type}" role="alert">
      <div class="toast-icon-base toast-${type}-icon">
        <svg class="w-5 h-5" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" 
             fill="currentColor" viewBox="0 0 20 20">
             ${type === "success" ?
    '<path d="M10 .5a9.5 9.5 0 1 0 9.5 9.5A9.51 9.51 0 0 0 10 .5Zm3.707 8.207-4 4a1 1 0 0 1-1.414 0l-2-2a1 1 0 0 1 1.414-1.414L9 10.586l3.293-3.293a1 1 0 0 1 1.414 1.414Z"/>' :
    ''}
             ${type === "error" ?
    '<path d="M10 .5a9.5 9.5 0 1 0 9.5 9.5A9.51 9.51 0 0 0 10 .5Zm3.707 11.793a1 1 0 1 1-1.414 1.414L10 11.414l-2.293 2.293a1 1 0 0 1-1.414-1.414L8.586 10 6.293 7.707a1 1 0 0 1 1.414-1.414L10 8.586l2.293-2.293a1 1 0 0 1 1.414 1.414L11.414 10l2.293 2.293Z"/>' :
    ''}
             ${type === "warning" ?
    '<path d="M10 .5a9.5 9.5 0 1 0 9.5 9.5A9.51 9.51 0 0 0 10 .5ZM10 15a1 1 0 1 1 0-2 1 1 0 0 1 0 2Zm1-4a1 1 0 0 1-2 0V6a1 1 0 0 1 2 0v5Z"/>' :
    ''}
        </svg>
        <span class="sr-only">Icon</span>
      </div>
      <div class="toast-message">${message}</div>
      <button type="button" class="toast-close-button ml-1" aria-label="Close">
        <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14">
              <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6"/>
        </svg>
      </button>
    </div>
  `;

  const toastInstance = Toastify({
    node: toastContent,
    duration: duration,
    close: false,
    gravity: "top",
    position: "right",
    stopOnFocus: true,
    style: {
      background: "transparent",
      boxShadow: "none",
      padding: "0",
      margin: "0",
    },
    onClick: function () {}
  });

  const closeButton = toastContent.querySelector('.toast-close-button');
  if (closeButton) {
    closeButton.addEventListener('click', () => {
      toastInstance.hideToast();
    });
  }

  toastInstance.showToast();
}
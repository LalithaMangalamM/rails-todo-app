function autoDismissAlert(alertId, timeout) {
  setTimeout(function() {
    var alertElement = document.getElementById(alertId);
    if (alertElement) {
      var alert = new bootstrap.Alert(alertElement);
      alert.close();
    }
  }, timeout);
}

document.addEventListener('DOMContentLoaded', function() {
  autoDismissAlert('autoDismissAlert', 5000);
});
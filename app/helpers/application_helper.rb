module ApplicationHelper
  def flash_class(level)
    bootstrap_alert_class = {
      "success" => "custom-alert-success",
      "error" => "custom-alert-error",
      "notice" => "custom-alert-notice",
      "alert" => "custom-alert-alert",
      "warn" => "custom-alert-warning"
    }
    bootstrap_alert_class[level]
  end
end
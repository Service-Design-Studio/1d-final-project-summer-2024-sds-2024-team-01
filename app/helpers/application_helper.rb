module ApplicationHelper
  def flash_class(key)
    case key.to_sym
    when :success then "custom-alert-success"
    when :error, :alert then "custom-alert-error"
    when :notice then "custom-alert-notice"
    when :warning then "custom-alert-warning"
    else "custom-alert-info"
    end
  end

  def flash_icon(key)
    case key.to_sym
    when :success then "fas fa-check-circle"
    when :error, :alert then "fas fa-exclamation-circle"
    when :notice then "fas fa-info-circle"
    when :warning then "fas fa-exclamation-triangle"
    else "fas fa-bell"
    end
  end
end
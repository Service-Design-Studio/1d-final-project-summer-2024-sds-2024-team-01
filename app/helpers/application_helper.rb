module ApplicationHelper
  # def flash_class(key)
  #   case key.to_sym
  #   when :success then "custom-alert-success"
  #   when :error, :alert then "custom-alert-error"
  #   when :notice then "custom-alert-notice"
  #   when :warning then "custom-alert-warning"
  #   else "custom-alert-info"
  #   end
  # end
  #
  # def flash_icon(key)
  #   case key.to_sym
  #   when :success then "fas fa-check-circle"
  #   when :error, :alert then "fas fa-exclamation-circle"
  #   when :notice then "fas fa-info-circle"
  #   when :warning then "fas fa-exclamation-triangle"
  #   else "fas fa-bell"
  #   end
  # end
  def percentage_indicator(api_endpoint: nil, unique_id: SecureRandom.hex(5), test_value: nil, show_condition: true)
    return unless show_condition

    content_tag :div, class: 'percentage-indicator-container' do
      indicator = content_tag :div, id: "percentage-indicator-#{unique_id}", 
                  class: 'percentage-indicator', 
                  data: { api_endpoint: api_endpoint, test_value: test_value } do
        content_tag :svg, viewBox: "0 0 36 36", class: 'circular-chart' do
          content_tag(:path, nil, class: 'circle-bg', d: "M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831") +
          content_tag(:path, nil, class: 'circle', stroke_dasharray: "0, 100", d: "M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831") +
          content_tag(:text, "0%", x: 18, y: 20.35, class: 'percentage')
        end
      end
      popup = content_tag :div, class: 'percentage-popup' do
        content_tag(:p, '', class: 'popup-content')
      end
      indicator + popup
    end
  end

  def chat_path_with_request_and_user(request, user, current_user_is_requester)
    return new_user_session_path if current_user.nil?
    if current_user_is_requester
      applicant_id = user.id
      requester_id = current_user.id
    else
      applicant_id = current_user.id
      requester_id = user.id
    end

    # Find or create the chat
    chat = Chat.find_or_create_by(
      request_id: request.id,
      applicant_id: applicant_id,
      requester_id: requester_id
    )

    chats_path(chat_id: chat.id)
  end
end

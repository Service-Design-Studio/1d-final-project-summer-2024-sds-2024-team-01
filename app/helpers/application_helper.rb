module ApplicationHelper
  def chat_path_with_request_and_user(request, user, current_user_is_requester)
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

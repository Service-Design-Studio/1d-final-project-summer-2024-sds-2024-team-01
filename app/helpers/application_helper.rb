module ApplicationHelper
    def chat_path_with_request_and_user(request, user)
      # Find or create the chat between the current user and the given user for the given request
      chat = Chat.find_or_create_by(
        request_id: request.id,
        applicant_id: current_user.id,
        requester_id: user.id
      ) || Chat.find_or_create_by(
        request_id: request.id,
        applicant_id: user.id,
        requester_id: current_user.id
      )
  
      chat_path(chat)
    end
  end
  
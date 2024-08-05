module ProfileHelper
  def calculate_slots_remaining(request)
    accepted_application_count = request.request_applications.where(status: 'Accepted').count
    request.number_of_pax - accepted_application_count
  end
end
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#
#
# db/seeds.rb
# ChatGPT is the goat

# For adding in dummy location data
# The SRID 4326 refers to the WGS 84 coordinate system, 
# which is the standard for latitude and longitude used 
# by GPS and many mapping services.

role_list = [  [1, "User"], [2, "Admin"], [3, "Corporate Manager"], [4, "Corporate User"], [5, "Charity Manager"]]

if Role.count == 0
  p "No roles found, seeding role data..."
  role_list.each do |role_id, role_name| 
    role = Role.new({id: role_id, role_name: role_name})
    role.save(validate: false) # Skipping validations
  end
  p "Created Roles"
end


users = [
  {
    name: "Alice Smith",
    nric: "S1234567A",
    number: "12345678",
    email: "alice.smith@example.com",
    status: "Active",
    role_id: 1,
  },
  {
    name: "Bob Johnson",
    nric: "S2345678B",
    number: "23456789",
    email: "bob.johnson@example.com",
    status: "Active",
    role_id: 2,
  },
  {
    name: "Charlie Lee",
    nric: "S3456789C",
    number: "34567890",
    email: "charlie.lee@example.com",
    status: "Active",
    role_id: 3,
    created_at: DateTime.now,
    updated_at: DateTime.now
  },
  {
    name: "Diana Patel",
    nric: "S4567890D",
    number: "45678901",
    email: "diana.patel@example.com",
    status: "Active",
    role_id: 1,
    created_at: DateTime.now,
    updated_at: DateTime.now
  },
  {
    name: "Evan Green",
    nric: "S5678901E",
    number: "56789012",
    email: "evan.green@example.com",
    status: "Active",
    role_id: 2,
    created_at: DateTime.now,
    updated_at: DateTime.now
  },
  {
    name: "Fiona Brown",
    nric: "S6789012F",
    number: "67890123",
    email: "fiona.brown@example.com",
    status: "Active",
    role_id: 3,
    created_at: DateTime.now,
    updated_at: DateTime.now
  },
  {
    name: "George White",
    nric: "S7890123G",
    number: "78901234",
    email: "george.white@example.com",
    status: "Active",
    role_id: 1,
    created_at: DateTime.now,
    updated_at: DateTime.now
  },
  {
    name: "Hannah Black",
    nric: "S8901234H",
    number: "89012345",
    email: "hannah.black@example.com",
    status: "Active",
    role_id: 2,
    created_at: DateTime.now,
    updated_at: DateTime.now
  },
  {
    name: "Ian Adams",
    nric: "S9012345I",
    number: "90123456",
    email: "ian.adams@example.com",
    status: "Active",
    role_id: 3,
    created_at: DateTime.now,
    updated_at: DateTime.now
  },
  {
    name: "Jane Clark",
    nric: "S0123456J",
    number: "01234567",
    email: "jane.clark@example.com",
    status: "Active",
    role_id: 1,
    created_at: DateTime.now,
    updated_at: DateTime.now
  }
]

if User.count == 0
  p "No users found, seeding user data..."
  users.each do |user_attributes|
    user = User.new(user_attributes)
    user.save!(validate: false)
    downloaded_image = URI.parse("https://innostudio.de/fileuploader/images/default-avatar.png").open
    user.avatar.attach(io: downloaded_image, filename: "foo.png")
  end
  p "Created Users"
end

requests = [
  {
    title: "Help with Gardening",
    description: "Looking for someone to help with my backyard garden",
    category: "Gardening",
    location: "POINT(40.712776 -74.005974)",
    date: Date.new(2024, 7, 1),
    number_of_pax: 2,
    start_time: '12:00',
    duration: 3,
    reward: "$50",
    reward_type: "Cash",
    status: "Open",
    # created_by: 12,
  },
  {
    title: "Dog Walking",
    description: "Need someone to walk my dog for an hour every afternoon",
    category: "Pet Care",
    location: "POINT(34.052235 -118.243683)",
    date: Date.new(2024, 7, 2),
    number_of_pax: 1,
    duration: 1,
    start_time: '12:00',
    reward: "$20",
    reward_type: "Cash",
    status: "Open",
    # created_by: 13,
  },
  {
    title: "Grocery Shopping",
    description: "Need help with weekly grocery shopping",
    category: "Errands",
    location: "POINT(51.507351 -0.127758)",
    date: Date.new(2024, 7, 3),
    number_of_pax: 1,
    duration: 2,
    start_time: '12:00',
    reward: "£30",
    reward_type: "Cash",
    status: "Open",
    # created_by: 14,
  },
  {
    title: "Moving Assistance",
    description: "Help needed with moving furniture to a new apartment",
    category: "Moving",
    location: "POINT(48.856613 2.352222)",
    date: Date.new(2024, 7, 4),
    number_of_pax: 3,
    duration: 5,
    start_time: '12:00',
    reward: "€100",
    reward_type: "Cash",
    status: "Open",
    # created_by: 15,
  },
  {
    title: "Painting Job",
    description: "Need help painting a room",
    category: "Household",
    location: "POINT(35.689487 139.691711)",
    date: Date.new(2024, 7, 5),
    number_of_pax: 2,
    duration: 4,
    start_time: '12:00',
    reward: "¥5000",
    reward_type: "Cash",
    status: "Open",
    # created_by: 16,
  },
  {
    title: "Car Wash",
    description: "Need someone to wash my car every weekend",
    category: "Automotive",
    location: "POINT(37.774929 -122.419416)",
    date: Date.new(2024, 7, 6),
    number_of_pax: 1,
    duration: 1,
    start_time: '12:00',
    reward: "$30",
    reward_type: "Cash",
    status: "Open",
    # created_by: 17,
  },
  {
    title: "Babysitting",
    description: "Looking for a babysitter for Saturday nights",
    category: "Childcare",
    location: "POINT(55.755825 37.617298)",
    date: Date.new(2024, 7, 7),
    number_of_pax: 1,
    duration: 5,
    start_time: '12:00',
    reward: "2000₽",
    reward_type: "Cash",
    status: "Open",
    # created_by: 18,
    created_at: DateTime.now,
    updated_at: DateTime.now
  },
  {
    title: "Tutoring",
    description: "Need a math tutor for high school student",
    category: "Education",
    location: "POINT(40.416775 -3.703790)",
    date: Date.new(2024, 7, 8),
    number_of_pax: 1,
    duration: 2,
    start_time: '12:00',
    reward: "€50",
    reward_type: "Cash",
    status: "Open",
    # created_by: 19,
    created_at: DateTime.now,
    updated_at: DateTime.now
  },
  {
    title: "Tech Support",
    description: "Help needed to set up a new computer",
    category: "IT",
    location: "POINT(39.904202 116.407394)",
    date: Date.new(2024, 7, 9),
    number_of_pax: 1,
    duration: 1,
    start_time: '12:00',
    reward: "¥200",
    reward_type: "Cash",
    status: "Open",
    # created_by: 20,
    created_at: DateTime.now,
    updated_at: DateTime.now
  },
  {
    title: "Photography",
    description: "Need a photographer for a family event",
    category: "Photography",
    location: "POINT(52.520008 13.404954)",
    date: Date.new(2024, 7, 10),
    number_of_pax: 1,
    duration: 3,
    start_time: '12:00',
    reward: "€150",
    reward_type: "Cash",
    status: "Open",
    # created_by: 21,
    created_at: DateTime.now,
    updated_at: DateTime.now
  }
]

comp_requests = [
  {
    title: "Help with Gardening",
    description: "Looking for someone to help with my backyard garden",
    category: "Gardening",
    location: "POINT(40.712776 -74.005974)",
    date: Date.new(2024, 7, 1),
    number_of_pax: 2,
    start_time: '12:00',
    duration: 3,
    reward: "$50",
    reward_type: "Cash",
    status: "Completed",
    # created_by: 1,
  },
  {
    title: "Dog Walking",
    description: "Need someone to walk my dog for an hour every afternoon",
    category: "Pet Care",
    location: "POINT(34.052235 -118.243683)",
    date: Date.new(2024, 7, 2),
    number_of_pax: 1,
    duration: 1,
    start_time: '12:00',
    reward: "$20",
    reward_type: "Cash",
    status: "Completed",
    # created_by: 2,
  },
  {
    title: "Grocery Shopping",
    description: "Need help with weekly grocery shopping",
    category: "Errands",
    location: "POINT(51.507351 -0.127758)",
    date: Date.new(2024, 7, 3),
    number_of_pax: 1,
    duration: 2,
    start_time: '12:00',
    reward: "£30",
    reward_type: "Cash",
    status: "Completed",
    # created_by: 3,
  },
  {
    title: "Moving Assistance",
    description: "Help needed with moving furniture to a new apartment",
    category: "Moving",
    location: "POINT(48.856613 2.352222)",
    date: Date.new(2024, 7, 4),
    number_of_pax: 3,
    duration: 5,
    start_time: '12:00',
    reward: "€100",
    reward_type: "Cash",
    status: "Completed",
    # created_by: 4,
  },
  {
    title: "Painting Job",
    description: "Need help painting a room",
    category: "Household",
    location: "POINT(35.689487 139.691711)",
    date: Date.new(2024, 7, 5),
    number_of_pax: 2,
    duration: 4,
    start_time: '12:00',
    reward: "¥5000",
    reward_type: "Cash",
    status: "Completed",
    # created_by: 5,
  }
]

begin
  if Request.count == 0
    p "No requests found, seeding fake request data..."
    user_ids = User.pluck(:id)

    requests.each do |rq_attr|
      rq_attr[:created_by] = user_ids.sample
      req = Request.create!(rq_attr)
      downloaded_imagee = URI.parse("https://www.houselogic.com/wp-content/uploads/2011/03/exterior-house-painting-epspainting-standard_c231db00f6cd6e9389489e72c0f32fe0.jpg").open
      req.thumbnail.attach(io: downloaded_imagee, filename: "painting.jpg")
    end
    comp_requests.each do |comp|
      comp[:created_by] = user_ids.sample
      compl = Request.create!(comp)
    end
  end
rescue => e
  p "Error during seeding: #{e.message}"
ensure
  p "seed completed"
end

# reviews = [
#   {
#     rating: 5,
#     review_content: "Nice",
#     created_at: DateTime.now,
#   },
#   {
#     rating: 3,
#     review_content: "Alright",
#     created_at: DateTime.now,
#   },  
#   {
#     rating: 1,
#     review_content: "Bad",
#     created_at: DateTime.now,
#   }
# ]

# begin
#   if Review.count == 0
#     p "No reviews found, seeding review data..."
#     completed_requests = Request.where(status: "Completed")
#     completed_requests.each do |request|
#       # The creator of the request is being reviewed
#       review_for_id = request.created_by
#       # Find a random user who didn't create the request to be the reviewer
#       review_by_id = User.where.not(id: review_for_id).pluck(:id).sample
#       reviews.each do |review_attr|
#         review_attr[:request_id] = request.id
#         review_attr[:review_for] = review_for_id
#         review_attr[:review_by] = review_by_id
#         review = Review.new(review_attr)
#         review.save!(validate: false)
#       end
#     end
#     p "Created Reviews"
#   end
# end
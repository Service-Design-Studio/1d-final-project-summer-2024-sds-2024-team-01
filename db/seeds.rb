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

#####################################################
# Check if roles exist before creating them
admin_role = Role.find_or_create_by!(role_name: 'Admin')
user_role = Role.find_or_create_by!(role_name: 'User')

# Check if users exist before creating them
admin = User.find_or_create_by!(email: 'admin@example.com') do |user|
  user.name = 'Admin User'
  user.number = '90000001'
  user.password = 'password'
  user.password_confirmation = 'password'
  user.role = admin_role
  user.status = 'normal'
end

user1 = User.find_or_create_by!(email: 'user1@example.com') do |user|
  user.name = 'User One'
  user.number = '90000002'
  user.password = 'password'
  user.password_confirmation = 'password'
  user.role = user_role
  user.status = 'normal'
end

user2 = User.find_or_create_by!(email: 'user2@example.com') do |user|
  user.name = 'User Two'
  user.number = '90000003'
  user.password = 'password'
  user.password_confirmation = 'password'
  user.role = user_role
  user.status = 'banned'
end

# Check if user reports exist before creating them
UserReport.find_or_create_by!(reported_user_id: user1.id, reported_by_id: admin.id) do |report|
  report.report_reason = 'Suspicious activity'
  report.status = 'under_review'
end

UserReport.find_or_create_by!(reported_user_id: user2.id, reported_by_id: admin.id) do |report|
  report.report_reason = 'Violation of terms'
  report.status = 'ban'
end



# users = [
#   {
#     name: "Alice Smith",
#     number: "12345678",
#     email: "alice.smith@example.com",
#     status: "Active",
#     role_id: 1,
#     password: 'password',
#     password_confirmation: 'password'
#   },
#   {
#     name: "Bob Johnson",
#     number: "23456789",
#     email: "bob.johnson@example.com",
#     status: "Active",
#     role_id: 2,
#     password: 'password',
#     password_confirmation: 'password'
#   },
#   {
#     name: "Charlie Lee",
#     number: "34567890",
#     email: "charlie.lee@example.com",
#     status: "Active",
#     role_id: 3,
#     created_at: DateTime.now,
#     updated_at: DateTime.now,
#     password: 'password',
#     password_confirmation: 'password'
#   },
#   {
#     name: "Diana Patel",
#     number: "45678901",
#     email: "diana.patel@example.com",
#     status: "Active",
#     role_id: 1,
#     created_at: DateTime.now,
#     updated_at: DateTime.now,
#     password: 'password',
#     password_confirmation: 'password'
#   },
#   {
#     name: "Evan Green",
#     number: "56789012",
#     email: "evan.green@example.com",
#     status: "Active",
#     role_id: 2,
#     created_at: DateTime.now,
#     updated_at: DateTime.now,
#     password: 'password',
#     password_confirmation: 'password'
#   },
#   {
#     name: "Fiona Brown",
#     number: "67890123",
#     email: "fiona.brown@example.com",
#     status: "Active",
#     role_id: 3,
#     created_at: DateTime.now,
#     password: 'password',
#     password_confirmation: 'password',
#     updated_at: DateTime.now
#   },
#   {
#     name: "George White",
#     number: "78901234",
#     email: "george.white@example.com",
#     status: "Active",
#     role_id: 1,
#     created_at: DateTime.now,
#     password: 'password',
#     password_confirmation: 'password',
#     updated_at: DateTime.now
#   },
#   {
#     name: "Hannah Black",
#     number: "89012345",
#     email: "hannah.black@example.com",
#     status: "Active",
#     role_id: 2,
#     created_at: DateTime.now,
#     password: 'password',
#     password_confirmation: 'password',
#     updated_at: DateTime.now
#   },
#   {
#     name: "Ian Adams",
#     number: "90123456",
#     email: "ian.adams@example.com",
#     status: "Active",
#     role_id: 3,
#     created_at: DateTime.now,
#     password: 'password',
#     password_confirmation: 'password',
#     updated_at: DateTime.now
#   },
#   {
#     name: "Jane Clark",
#     number: "01234567",
#     email: "jane.clark@example.com",
#     status: "Active",
#     role_id: 1,
#     created_at: DateTime.now,
#     password: 'password',
#     password_confirmation: 'password',
#     updated_at: DateTime.now
#   }
# ]
#
# if User.count == 0
#   p "No users found, seeding user data..."
#   users.each do |user_attributes|
#     user = User.new(user_attributes)
#     user.save # Skipping validations
#     downloaded_image = URI.parse("https://innostudio.de/fileuploader/images/default-avatar.png").open
#     user.avatar.attach(io: downloaded_image, filename: "foo.png")
#   end
#   p "Created Users"
# end
#
#
# requests = [
#   {
#     title: "Help with Gardening",
#     description: "Looking for someone to help with my backyard garden",
#     category: "Gardening",
#     location: "POINT(40.712776 -74.005974)",
#     date: Date.new(2024, 7, 1),
#     number_of_pax: 2,
#     start_time: '12:00',
#     duration: 3,
#     reward: "$50",
#     reward_type: "Cash",
#     status: "Open",
#     created_by: 1,
#   },
#   {
#     title: "Dog Walking",
#     description: "Need someone to walk my dog for an hour every afternoon",
#     category: "Pet Care",
#     location: "POINT(34.052235 -118.243683)",
#     date: Date.new(2024, 7, 2),
#     number_of_pax: 1,
#     duration: 1,
#     start_time: '12:00',
#     reward: "$20",
#     reward_type: "Cash",
#     status: "Open",
#     created_by: 2,
#   },
#   {
#     title: "Grocery Shopping",
#     description: "Need help with weekly grocery shopping",
#     category: "Errands",
#     location: "POINT(51.507351 -0.127758)",
#     date: Date.new(2024, 7, 3),
#     number_of_pax: 1,
#     duration: 2,
#     start_time: '12:00',
#     reward: "£30",
#     reward_type: "Cash",
#     status: "Open",
#     created_by: 3,
#   },
#   {
#     title: "Moving Assistance",
#     description: "Help needed with moving furniture to a new apartment",
#     category: "Moving",
#     location: "POINT(48.856613 2.352222)",
#     date: Date.new(2024, 7, 4),
#     number_of_pax: 3,
#     duration: 5,
#     start_time: '12:00',
#     reward: "€100",
#     reward_type: "Cash",
#     status: "Open",
#     created_by: 4,
#   },
#   {
#     title: "Painting Job",
#     description: "Need help painting a room",
#     category: "Household",
#     location: "POINT(35.689487 139.691711)",
#     date: Date.new(2024, 7, 5),
#     number_of_pax: 2,
#     duration: 4,
#     start_time: '12:00',
#     reward: "¥5000",
#     reward_type: "Cash",
#     status: "Open",
#     created_by: 5,
#   },
#   {
#     title: "Car Wash",
#     description: "Need someone to wash my car every weekend",
#     category: "Automotive",
#     location: "POINT(37.774929 -122.419416)",
#     date: Date.new(2024, 7, 6),
#     number_of_pax: 1,
#     duration: 1,
#     start_time: '12:00',
#     reward: "$30",
#     reward_type: "Cash",
#     status: "Open",
#     created_by: 6,
#   },
#   {
#     title: "Babysitting",
#     description: "Looking for a babysitter for Saturday nights",
#     category: "Childcare",
#     location: "POINT(55.755825 37.617298)",
#     date: Date.new(2024, 7, 7),
#     number_of_pax: 1,
#     duration: 5,
#     start_time: '12:00',
#     reward: "2000₽",
#     reward_type: "Cash",
#     status: "Open",
#     created_by: 7,
#     created_at: DateTime.now,
#     updated_at: DateTime.now
#   },
#   {
#     title: "Tutoring",
#     description: "Need a math tutor for high school student",
#     category: "Education",
#     location: "POINT(40.416775 -3.703790)",
#     date: Date.new(2024, 7, 8),
#     number_of_pax: 1,
#     duration: 2,
#     start_time: '12:00',
#     reward: "€50",
#     reward_type: "Cash",
#     status: "Open",
#     created_by: 8,
#     created_at: DateTime.now,
#     updated_at: DateTime.now
#   },
#   {
#     title: "Tech Support",
#     description: "Help needed to set up a new computer",
#     category: "IT",
#     location: "POINT(39.904202 116.407394)",
#     date: Date.new(2024, 7, 9),
#     number_of_pax: 1,
#     duration: 1,
#     start_time: '12:00',
#     reward: "¥200",
#     reward_type: "Cash",
#     status: "Open",
#     created_by: 9,
#     created_at: DateTime.now,
#     updated_at: DateTime.now
#   },
#   {
#     title: "Photography",
#     description: "Need a photographer for a family event",
#     category: "Photography",
#     location: "POINT(52.520008 13.404954)",
#     date: Date.new(2024, 7, 10),
#     number_of_pax: 1,
#     duration: 3,
#     start_time: '12:00',
#     reward: "€150",
#     reward_type: "Cash",
#     status: "Open",
#     created_by: 10,
#     created_at: DateTime.now,
#     updated_at: DateTime.now
#   }
# ]
#
# if Request.count == 0
#   p "No requests found, seeding fake request data..."
#   requests.each do |rq_attr|
#     req = Request.new(rq_attr)
#     req.save
#     downloaded_imagee = URI.parse("https://www.houselogic.com/wp-content/uploads/2011/03/exterior-house-painting-epspainting-standard_c231db00f6cd6e9389489e72c0f32fe0.jpg").open
#       req.thumbnail.attach(io: downloaded_imagee, filename: "painting.jpg")
#   end
#   p "Fake request data seeded"
# end
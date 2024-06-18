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
    profile_picture: "https://example.com/profiles/user1.jpg",
    name: "Alice Smith",
    nric: "S1234567A",
    number: "12345678",
    email: "alice.smith@example.com",
    status: "Active",
    role_id: 1,
  },
  {
    profile_picture: "https://example.com/profiles/user2.jpg",
    name: "Bob Johnson",
    nric: "S2345678B",
    number: "23456789",
    email: "bob.johnson@example.com",
    status: "Active",
    role_id: 2,
  },
  {
    profile_picture: "https://example.com/profiles/user3.jpg",
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
    profile_picture: "https://example.com/profiles/user4.jpg",
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
    profile_picture: "https://example.com/profiles/user5.jpg",
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
    profile_picture: "https://example.com/profiles/user6.jpg",
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
    profile_picture: "https://example.com/profiles/user7.jpg",
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
    profile_picture: "https://example.com/profiles/user8.jpg",
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
    profile_picture: "https://example.com/profiles/user9.jpg",
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
    profile_picture: "https://example.com/profiles/user10.jpg",
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
    user.save(validate: false) # Skipping validations
  end
  p "Created Users"
end



if Request.count == 0
p "No requests found, seeding fake request data..."
  Request.create!([
    {
      title: "Help with Gardening",
      description: "Looking for someone to help with my backyard garden",
      thumbnail_pic: "https://example.com/thumbnails/gardening.jpg",
      category: "Gardening",
      location: "POINT(40.712776 -74.005974)",
      date: Date.new(2024, 7, 1),
      number_of_pax: 2,
      duration: 3,
      reward: "$50",
      reward_type: "Cash",
      status: "Open",
      created_by: 1,
    },
    {
      title: "Dog Walking",
      description: "Need someone to walk my dog for an hour every afternoon",
      thumbnail_pic: "https://example.com/thumbnails/dog_walking.jpg",
      category: "Pet Care",
      location: "POINT(34.052235 -118.243683)",
      date: Date.new(2024, 7, 2),
      number_of_pax: 1,
      duration: 1,
      reward: "$20",
      reward_type: "Cash",
      status: "Open",
      created_by: 2,
    },
    {
      title: "Grocery Shopping",
      description: "Need help with weekly grocery shopping",
      thumbnail_pic: "https://example.com/thumbnails/grocery_shopping.jpg",
      category: "Errands",
      location: "POINT(51.507351 -0.127758)",
      date: Date.new(2024, 7, 3),
      number_of_pax: 1,
      duration: 2,
      reward: "£30",
      reward_type: "Cash",
      status: "Open",
      created_by: 3,
    },
    {
      title: "Moving Assistance",
      description: "Help needed with moving furniture to a new apartment",
      thumbnail_pic: "https://example.com/thumbnails/moving.jpg",
      category: "Moving",
      location: "POINT(48.856613 2.352222)",
      date: Date.new(2024, 7, 4),
      number_of_pax: 3,
      duration: 5,
      reward: "€100",
      reward_type: "Cash",
      status: "Open",
      created_by: 4,
    },
    {
      title: "Painting Job",
      description: "Need help painting a room",
      thumbnail_pic: "https://example.com/thumbnails/painting.jpg",
      category: "Household",
      location: "POINT(35.689487 139.691711)",
      date: Date.new(2024, 7, 5),
      number_of_pax: 2,
      duration: 4,
      reward: "¥5000",
      reward_type: "Cash",
      status: "Open",
      created_by: 5,
    },
    {
      title: "Car Wash",
      description: "Need someone to wash my car every weekend",
      thumbnail_pic: "https://example.com/thumbnails/car_wash.jpg",
      category: "Automotive",
      location: "POINT(37.774929 -122.419416)",
      date: Date.new(2024, 7, 6),
      number_of_pax: 1,
      duration: 1,
      reward: "$30",
      reward_type: "Cash",
      status: "Open",
      created_by: 6,
    },
    {
      title: "Babysitting",
      description: "Looking for a babysitter for Saturday nights",
      thumbnail_pic: "https://example.com/thumbnails/babysitting.jpg",
      category: "Childcare",
      location: "POINT(55.755825 37.617298)",
      date: Date.new(2024, 7, 7),
      number_of_pax: 1,
      duration: 5,
      reward: "2000₽",
      reward_type: "Cash",
      status: "Open",
      created_by: 7,
      created_at: DateTime.now,
      updated_at: DateTime.now
    },
    {
      title: "Tutoring",
      description: "Need a math tutor for high school student",
      thumbnail_pic: "https://example.com/thumbnails/tutoring.jpg",
      category: "Education",
      location: "POINT(40.416775 -3.703790)",
      date: Date.new(2024, 7, 8),
      number_of_pax: 1,
      duration: 2,
      reward: "€50",
      reward_type: "Cash",
      status: "Open",
      created_by: 8,
      created_at: DateTime.now,
      updated_at: DateTime.now
    },
    {
      title: "Tech Support",
      description: "Help needed to set up a new computer",
      thumbnail_pic: "https://example.com/thumbnails/tech_support.jpg",
      category: "IT",
      location: "POINT(39.904202 116.407394)",
      date: Date.new(2024, 7, 9),
      number_of_pax: 1,
      duration: 1,
      reward: "¥200",
      reward_type: "Cash",
      status: "Open",
      created_by: 9,
      created_at: DateTime.now,
      updated_at: DateTime.now
    },
    {
      title: "Photography",
      description: "Need a photographer for a family event",
      thumbnail_pic: "https://example.com/thumbnails/photography.jpg",
      category: "Photography",
      location: "POINT(52.520008 13.404954)",
      date: Date.new(2024, 7, 10),
      number_of_pax: 1,
      duration: 3,
      reward: "€150",
      reward_type: "Cash",
      status: "Open",
      created_by: 10,
      created_at: DateTime.now,
      updated_at: DateTime.now
    }
  ])
  p "Fake request data seeded"
end

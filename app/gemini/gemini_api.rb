require 'gemini-ai'

#test user profile
user = {
  name: 'Alice Greenfield', 
  bio: 'I am a dedicated elementary school teacher from Simei, Singapore, with a passion for gardening and community service. With over a decade of experience in organic gardening and landscape design, Alice has honed her skills in creating beautiful and sustainable green spaces. She volunteers at the local community garden, where she manages plots and conducts workshops for children, fostering a love for nature in the younger generation.
        In her free time, Alice enjoys cooking with fresh ingredients from her garden, bird watching, and reading. Her enthusiasm for the outdoors and helping others drives her to participate in community clean-up and planting events. With her extensive gardening knowledge and commitment to environmental sustainability, Alice is a valuable asset to any volunteer gardening project.'
}


# test request profile
request = {
  name: 'Help with gardening',
  description: 'I am looking for someone to help me with my garden. I need help with planting, weeding, and general maintenance. I have a small garden in my backyard that I would like to turn into a beautiful and productive space. I am looking for someone who has experience with organic gardening and is passionate about sustainability. If you are interested in helping out, please get in touch!',
  date: '2022-06-01',
  time: '10:00 AM',
  number_of_volunteers: 5,
  location: 'SUTD, Singapore',
  rewards: 'None'
}


# With an API key
client = Gemini.new(
  credentials: {
    service: 'generative-language-api',
    api_key: ENV['GOOGLE_API_KEY']
  },
  options: { model: 'gemini-pro', server_sent_events: true }
)

prompt = <<-PROMPT
Compare the following two profiles and provide a numerical match percentage based on their compatibility:

Volunteer Profile:
Name: #{user[:name]}
Bio: #{user[:bio]}

Request Profile:
Name: #{request[:name]}
Description: #{request[:description]}
Date: #{request[:date]}
Time: #{request[:time]}
Number of Volunteers: #{request[:number_of_volunteers]}
Location: #{request[:location]}
Rewards: #{request[:rewards]}
PROMPT

# Send the prompt to the Gemini API
response = client.stream_generate_content({
  contents: { role: 'user', parts: { text: prompt } }
})

# Extract and print the match percentage from the response
puts response

# result = client.stream_generate_content({
#   contents: { role: 'user', parts: { text: 'hi!' } }
# })
# puts result
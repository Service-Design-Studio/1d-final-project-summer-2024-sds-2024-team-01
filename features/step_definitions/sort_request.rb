And('I have a different request') do
    Request.create(
      title: 'Test Request',
      description: 'Need someone to walk my dog for an hour every afternoon',
      category: 'Pet Care',
      location: 'POINT(34.052235 -118.243683)',
      date: Date.new(2024, 7, 2),
      number_of_pax: 1,
      duration: 1,
      start_time: '12:00',
      reward: '$20',
      reward_type: 'Cash',
      status: 'Open',
      created_by: User.where(name: 'Harrison Ford').take.id
    )
  end
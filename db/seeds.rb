
puts "creating organisations"

  Organisation.create(
    name:"Sushi Sushifu", hourly_rate: 18.50
  )
  Organisation.create(
    name:"Champions Amigo", hourly_rate: 20.00
  )
  Organisation.create(
    name:"Carly’s Cafe", hourly_rate: 16.00
  )

puts "done"
  # puts "creating users"

  # User.create(
  #   name: "Carly Luo", email: "carly@carly.com", password:"123321"
  # )
  # User.create(
  #   name: "Dan Newton", email: "dan@new.com", password:"123321"
  # )
  # User.create(
  #   name: "Louis Williams", email: "loius@will.com", password:"123321"
  # )

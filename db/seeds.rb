# Find or create the main user
me = User.find_or_create_by!(email: "imagevogue8@gmail.com") do |user|
    user.password = 'password'
    # Add any additional attributes here
  end
  
  # Create listings for the main user
  10.times do
    Listing.create!(
      host: me,
      title: Faker::Lorem.words.join(" "),
      description: Faker::Lorem.paragraphs.join("\n"),
      max_guests: (1...15).to_a.sample,
      address: Faker::Address.street_address,
      city: Faker::Address.city,
      postal_code: Faker::Address.postcode,
      country: 'FR',
      status: [:draft, :published].sample
    )
  end
  
  # Create additional hosts and listings
  10.times do
    host = User.create!(
      email: Faker::Internet.email,
      password: Faker::Internet.password
    )
  
    10.times do
      Listing.create!(
        host: host,
        title: Faker::Lorem.words.join(" "),
        description: Faker::Lorem.paragraphs.join("\n"),
        max_guests: (1...15).to_a.sample,
        address: Faker::Address.street_address,
        city: Faker::Address.city,
        postal_code: Faker::Address.postcode,
        country: 'FR',
        status: [:draft, :published].sample
      )
    end
  end
puts 'seeding succefully'  
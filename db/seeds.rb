require 'open-uri'
Listing.destroy_all

# Default set of photos to be added to each listing
DEFAULT_PHOTO_FILENAMES = ["home1.png", "bathroom.jpg", "house1.png","home2.png", "home3.png", "bedroom.jpg"]

# Method to get the full path of an image file
def get_image_path(filename)
  Rails.root.join('app', 'assets', 'images', filename)
end

# Find or create the main user
me = User.find_or_create_by!(email: "imagevogue8@gmail.com") do |user|
  user.password = 'password'
  # Add any additional attributes here
end

# Create listings for the main user
10.times do |i|
  listing = Listing.create!(
    host: me,
    title: Faker::Lorem.words(number: 3).join(" "),
    description: Faker::Lorem.paragraphs(number: 2).join("\n"),
    max_guests: rand(1..10),   # Ensure max_guests is within the valid range
    address: Faker::Address.street_address,
    city: Faker::Address.city,
    postal_code: Faker::Address.postcode,
    country: 'FR',
    status: [:draft, :published].sample,
    nightly_price: rand(5000..50000),      # Adding nightly price
    cleaning_fee: rand(1000..10000)        # Adding cleaning fee
  )

  # Shuffle the DEFAULT_PHOTO_FILENAMES array to randomize image assignment
  DEFAULT_PHOTO_FILENAMES.shuffle!

  # Create photos for the listing using a subset of images
  DEFAULT_PHOTO_FILENAMES.each do |filename|
    image_path = get_image_path(filename)
    if File.exist?(image_path)
      listing.photos.create!(
        image: File.open(image_path),
        caption: Faker::Lorem.sentence
      )
    else
      puts "Image file #{image_path} not found, skipping."
    end
  end
end

# Create additional hosts and listings
3.times do |i|
  host = User.create!(
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )
  puts "User with email #{host.email} created with password: #{host.password}"

  10.times do |j|
    listing = Listing.create!(
      host: host,
      title: Faker::Lorem.words(number: 3).join(" "),
      description: Faker::Lorem.paragraphs(number: 2).join("\n"),
      max_guests: rand(1..10),   # Ensure max_guests is within the valid range
      address: Faker::Address.street_address,
      city: Faker::Address.city,
      postal_code: Faker::Address.postcode,
      country: 'FR',
      status: [:draft, :published].sample,
      nightly_price: rand(5000..50000),      # Adding nightly price
      cleaning_fee: rand(1000..10000)        # Adding cleaning fee
    )

    # Shuffle the DEFAULT_PHOTO_FILENAMES array to randomize image assignment
    DEFAULT_PHOTO_FILENAMES.shuffle!

    # Create photos for the listing using a subset of images
    DEFAULT_PHOTO_FILENAMES.each do |filename|
      image_path = get_image_path(filename)
      if File.exist?(image_path)
        listing.photos.create!(
          image: File.open(image_path),
          caption: Faker::Lorem.sentence
        )
      else
        puts "Image file #{image_path} not found, skipping."
      end
    end
  end
end

puts 'Seeding successfully'

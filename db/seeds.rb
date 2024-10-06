# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
# #   Character.create(name: "Luke", movie: movies.first)

# SAVE_USERS = [
#     "BEATZ GOD",
#     "KooShnoo",
#     "lsherm",
#     # "Pete",
# ]

# SAVE_TRACKS = [
#   "Ishan's Campanella",
#   "Ghost",
#   # "Concrete Skies",
# ]


# require "open-uri"
# # ApplicationRecord.transaction do 
#     puts "Destroying ActiveStorage associations..."

#     User.all.each do |user|
#       if !SAVE_USERS.include? (user.username) 
#         user.photo.purge
#         user.destroy
#       end
#     end
    
#     Track.all.each do |track|
#       if !SAVE_TRACKS.include? track.title
#         track.photo.purge if track.photo.attached?
#         track.source.purge
#         track.destroy
#       end
#     end

#     puts "Destroying tables..."
#     # Unnecessary if using `rails db:seed:replant`
   
  
#     puts "Resetting primary keys..."
#     # For easy testing, so that after seeding, the first `User` has `id` of 1
#     ApplicationRecord.connection.reset_pk_sequence!('users')
#     ApplicationRecord.connection.reset_pk_sequence!('tracks')
  
#     puts "Creating users..."
#     # Create one user with an easy to remember username, email, and password:
#     User.create!(
#       username: 'Demo-lition', 
#       email: 'demo@user.io', 
#       password: 'password'
#     )
  
#     # More users
#     50.times do 
#       username = Faker::Internet.unique.username(specifier: 3);
#       while username.include?('.') do
#         username = Faker::Internet.unique.username(specifier: 3);
#       end
#       User.create!({
#         username: username,
#         email: Faker::Internet.unique.email,
#         password: 'password'
#       }) 
#     end

#     # puts('Creating tracks...')
#     # f = URI.open(SEED_TRACKS_LIST[1][:source_url])
#     # t = Track.new({
#     #   :title => SEED_TRACKS_LIST[1][:title],
#     #   :description => SEED_TRACKS_LIST[1][:description],
#     #   :artist_id => Random.new().rand(13..21),
#     #   :genre => SEED_TRACKS_LIST[1][:genre],
#     #   :duration => 123,
#     #   :file_type => SEED_TRACKS_LIST[1][:file_type]
#     # })
#     # t.source.attach(io: f, filename: "Hudson+Mohawke+-+Cbat.mp3")
#     # t.save! if t.source.attached?
#     # puts('Created CBAT')

#     # 10.times do
#     #   t = Track.new({
#     #     title: Faker::Music::PearlJam.unique.song,
#     #     artist_id: Random.new().rand(1..11),
#     #     file_type: 'mp3',
#     #     duration: [25, 420].sample
#     #   })
#     #   t.photo.purge
#     #   t.photo.attach(io: URI.open("https://wavecave-seeds.s3.amazonaws.com/Screenshot+2024-01-19+153436.png"), filename: "Screenshot+2024-01-19+153436.png" ) if i == 0 
#     #   t.save!
#     # end
  
#     puts "Done!"
# end
  # comment
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

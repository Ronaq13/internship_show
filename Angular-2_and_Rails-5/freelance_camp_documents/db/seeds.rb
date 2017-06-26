# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |d|
  FreelanceDocument.create(
      title: "Document #{d}",
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi aliquip ex ea commodo consequat.",
      file_url: "https://drive.google.com/file/d/0B6-trA3vweT2NE9iUWtRa0tNVTQ/view?usp=sharing",
      image_url: "https://s3.amazonaws.com/devcamp-static/images/freelance-img.jpg"
  )
end




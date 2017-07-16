# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# user = CreateAdminService.new.call
# puts 'CREATED ADMIN USER: ' << user.email
#
# CreatePlanService.new.call
# puts 'CREATED PLANS'


# Categories

$categories = {
    assicurazioni:{
        altro: ['casa', 'infortuni', 'auto', 'malattia', 'cyber_risk', 'protection indemnity'],
        vita:  ['mista', 'temporanea caso morte', 'vita intera', 'rendità', 'unit linked', 'pir', 'keyman']
    }
}

$categories.each do |key, value|
  level_1 = Category.find_or_create_by(name:key)
  if value.is_a?(Hash)
    value.each do |key2, val2|
      level_2 = Category.find_or_create_by(name:key2, parent: level_1)
      if val2.is_a?(Array)
        val2.each do |key3,val3|
          level_3 = Category.find_or_create_by(name:key3, parent: level_2)
        end
      end
    end
  end
end

# --== Generate Sample Users creator

20.times do
  user = User.new

  user.name = Faker::Name.name
  user.email = Faker::Internet.free_email(Faker::Internet.user_name)
  user.password = Faker::Internet.password(8)
  user.password_confirmation = user.password
  user.image = Faker::Avatar.image
  user.role = 'basic'

  user.save

# --== Generate Sample Races
  race = user.races.build

  race.name = Faker::Space.star
  race.description = Faker::Matz.quote
  race.category = Category.find_by_name(:assicurazioni).children.last.children.sample
  race.race_value = 100000
  race.compensation_amount = 10000
  race.compensation_kind = 'money'
  race.pieces_amount = 10
  race.compensation_start_amount = 0
  race.max_attendees = 10

  race.save
end

# --== Generate Sample User Attendees

80.times do

  user_attendee = User.new

  user_attendee.name = Faker::Name.name
  user_attendee.email = Faker::Internet.free_email(Faker::Internet.user_name)
  user_attendee.password = Faker::Internet.password(8)
  user_attendee.password_confirmation = user_attendee.password
  user_attendee.image = Faker::Avatar.image
  user_attendee.role = 'basic'

  user_attendee.save

  Attendee.find_or_create_by(attendee:user_attendee, race:Race.all.order("RAND()").first)

end
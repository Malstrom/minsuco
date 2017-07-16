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


  portafoglio = 100


  race_values = %W(10000 50000 100000 75000 25000)
  race_comp_kinds = %w(0 1)
  race_attendees = rand(10..50)
  compensation_start_amounts = %W(0 0 0 0 500 1000)

  def time_rand from = 0.0, to = Time.now
    Time.at(from + rand * (to.to_f - from.to_f))
  end

  race.name = Faker::Space.star
  race.description = Faker::Matz.quote
  race.category = Category.find_by_name(:assicurazioni).children.last.children.sample
  race.race_value = race_values.sample
  race.compensation_kind = race_comp_kinds.sample
  race.pieces_amount = 10
  race.compensation_start_amount = compensation_start_amounts.sample
  race.max_attendees = race_attendees
  race.starts_at = rand(Date.civil(2017, 1, 1)..Date.civil(2017, 12, 31))
  race.ends_at = rand(race.starts_at..Date.civil(2017, 12, 31))

# race.compensation_amount = race.race_value / race.max_attendees


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

  rand(1..5).times do
    Attendee.create(attendee:user_attendee, race:Race.all.order("RAND()").first)
  end
end
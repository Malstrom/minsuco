# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

start = Time.now
# code to time

# user = CreateAdminService.new.call
# puts 'CREATED ADMIN USER: ' << user.email

CreatePlanService.new.call
puts 'CREATED PLANS'

# Categories

$categories = {
  assicurazioni: {
    altro: ['casa', 'infortuni', 'auto', 'malattia', 'cyber risk', 'protection indemnity'],
    vita:  ['mista', 'TCM', 'vita intera', 'rendita', 'unit linked', 'pir', 'keyman']
  }
}

$categories.each do |key, value|
  level_1 = Category.find_or_create_by(name: key)
  next unless value.is_a?(Hash)
  value.each do |key2, val2|
    level_2 = Category.find_or_create_by(name: key2, parent: level_1)
    next unless val2.is_a?(Array)
    val2.each do |key3, _val3|
      level_3 = Category.find_or_create_by(name: key3, parent: level_2)
    end
  end
end

# --== Generate Sample Users creator

10.times do
  user = User.new

  user.name = Faker::Name.name
  user.email = Faker::Internet.free_email(Faker::Internet.user_name)
  user.password = Faker::Internet.password(8)
  user.password_confirmation = user.password
  user.image = Faker::Avatar.image
  user.role = %w[pro_creator premium].sample
  user.kind = %w[broker agent].sample
  user.plan = [Plan.find_by_stripe_id('pro_creator'), Plan.find_by_stripe_id('premium')].sample
  user.rui = 7_774_356_463_777

  user.save

  # p user.errors.full_messages
  # --== Generate Sample Races
  race = user.races.build

  race_values = %w[10000 50000 100000 75000 25000]
  compensation_start_amounts = %w[0 0 0 0 500 1000]

  def time_rand(from = 0.0, to = Time.now)
    Time.at(from + rand * (to.to_f - from.to_f))
  end

  race_saved = false
  until race_saved

    race.permalink = Faker::App.name
    race.description = Faker::Matz.quote
    race.category = Category.find_by_name(:assicurazioni).children.last.children.sample
    race.race_value = race_values.sample
    race.compensation_start_amount = compensation_start_amounts.sample
    race.starts_at = rand(DateTime.now..DateTime.now + 7.days)
    race.ends_at = race.starts_at + rand(30..90).days
    race.kind = %w[open close].sample
    race.status = 'started'
    race.recipients = %w[broker agent for_all].sample
    race.price = 2900
    race.permalink = race.permalink

    race.commissions.build(value: 5,  duration: 1)
    race.commissions.build(value: 10, duration: 5)

    race_saved = race.save

    p race.errors.full_messages
  end
end

# --== Generate Sample User Attendees

40.times do
  user_attendee = User.new

  user_attendee.name = Faker::Name.name
  user_attendee.email = Faker::Internet.free_email(Faker::Internet.user_name)
  user_attendee.password = Faker::Internet.password(8)
  user_attendee.password_confirmation = user_attendee.password
  user_attendee.image = Faker::Avatar.image
  user_attendee.role = %w[basic pro_attendee].sample
  user_attendee.kind = %w[broker agent].sample
  user_attendee.plan = [Plan.find_by_stripe_id('pro_attendee'), Plan.find_by_stripe_id('premium')].sample
  user_attendee.rui = 74_356_634_677_777

  user_attendee.save

  rand(1..3).times do
    Attendee.create(user: user_attendee,
                    race: Race.all.order('RAND()').first,
                    status: :confirmed,
                    pieces_attributes: [
                      { name: Faker::Name.name, value: rand(1000..3000), duration: rand(1..30) },
                      { name: Faker::Name.name, value: rand(1000..3000), duration: rand(1..30) },
                      { name: Faker::Name.name, value: rand(1000..3000), duration: rand(1..30) }
                    ])
  end
end

finish = Time.now

diff = finish - start

p "execute in #{diff}"

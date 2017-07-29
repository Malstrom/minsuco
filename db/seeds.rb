# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

CreatePlanService.new.call
puts 'CREATED PLANS'

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
  user.role = %w(pro_creator premium).sample
  user.kind = %w(broker agent).sample
  user.plan_id = [Plan.find(2),Plan.find(3)].sample()


  user.save

  # p user.errors.full_messages
# --== Generate Sample Races
  race = user.races.build


  portafoglio = 100


  race_values = %W(10000 50000 100000 75000 25000)
  race_comp_kinds = %w(perc money)
  race_attendees = rand(10..50)
  compensation_start_amounts = %W(0 0 0 0 500 1000)

  def time_rand from = 0.0, to = Time.now
    Time.at(from + rand * (to.to_f - from.to_f))
  end

  race_saved = false
  until race_saved

    race.name = Faker::App.name
    race.description = Faker::Matz.quote
    race.category = Category.find_by_name(:assicurazioni).children.last.children.sample
    race.race_value = race_values.sample
    race.pieces_amount = rand(5..50)
    race.compensation_start_amount = compensation_start_amounts.sample
    race.max_attendees = race_attendees
    race.starts_at = rand(DateTime.now - 7.days..DateTime.now + 7.days)
    race.ends_at = race.starts_at + rand( 30..90 ).days
    race.compensation_amount = rand(5..50)
    race.kind = %w(pay_for_publish pay_for_join).sample
    race.status = 'started'
    race.recipients = %w(brokers agents all).sample
    race.price = 2900
    race.permalink = race.name

    race_saved = race.save

      p race.errors.full_messages
  end
end

# --== Generate Sample User Attendees

80.times do

  user_attendee = User.new

  user_attendee.name = Faker::Name.name
  user_attendee.email = Faker::Internet.free_email(Faker::Internet.user_name)
  user_attendee.password = Faker::Internet.password(8)
  user_attendee.password_confirmation = user_attendee.password
  user_attendee.image = Faker::Avatar.image
  user_attendee.role = %w(basic pro_attendee).sample
  user_attendee.kind = %w(broker agent).sample
  user_attendee.plan_id = [Plan.find(2),Plan.find(3)].sample()

  user_attendee.save

  rand(1..5).times do
    Attendee.create(attendee:user_attendee, race:Race.all.order("RAND()").first)
  end
end

# --== Highlight some races

races_to_highlight = Race.order("RAND()").limit(5)

races_to_highlight.each do |race|
  race_to_highlight = race.featured_races.build

  race_to_highlight.starts_at = rand(race.starts_at..rand(race.starts_at + 0.days..race.starts_at + 20.days))
  race_to_highlight.ends_at = rand(race_to_highlight.starts_at..rand(race_to_highlight.starts_at + 2.days..race_to_highlight.starts_at + 30.days))

  race_to_highlight.save
end


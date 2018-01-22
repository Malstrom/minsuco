class CreatePlanService
  def call
    p1 = Plan.where(name: 'basic').first_or_initialize do |p|
      p.amount = 0
      p.interval = 'month'
      p.stripe_id = 'basic'
    end
    p1.save!
    p2 = Plan.where(name: 'light').first_or_initialize do |p|
      p.amount = 400
      p.interval = 'month'
      p.stripe_id = 'light'
    end
    p2.save!(:validate => false)
    p3 = Plan.where(name: 'Pro-creator').first_or_initialize do |p|
      p.amount = 2900
      p.interval = 'month'
      p.stripe_id = 'pro_creator'
    end
    p3.save!(:validate => false)
    p4 = Plan.where(name: 'Pro-attendee').first_or_initialize do |p|
      p.amount = 900
      p.interval = 'month'
      p.stripe_id = 'pro_attendee'
    end
    p4.save!(:validate => false)
    p5 = Plan.where(name: 'Basic').first_or_initialize do |p|
      p.amount = 0
      p.interval = 'month'
      p.stripe_id = 'basic'
    end
    p5.save!(:validate => false)
  end
end

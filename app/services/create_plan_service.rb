class CreatePlanService
  def call
    p1 = Plan.where(name: 'Enterprise').first_or_initialize do |p|
      p.amount = 2900
      p.interval = 'month'
      p.stripe_id = 'enterprise'
    end
    p1.save!(:validate => false)
    p2 = Plan.where(name: 'Premium').first_or_initialize do |p|
      p.amount = 1900
      p.interval = 'month'
      p.stripe_id = 'premium'
    end
    p2.save!(:validate => false)
    p3 = Plan.where(name: 'Pro-creator').first_or_initialize do |p|
      p.amount = 900
      p.interval = 'month'
      p.stripe_id = 'pro_creator'
    end
    p3.save!(:validate => false)
    p4 = Plan.where(name: 'Pro-attendee').first_or_initialize do |p|
      p.amount = 0
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

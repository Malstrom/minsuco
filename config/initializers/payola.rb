StripeEvent.signing_secret = Rails.application.secrets.stripe_signing_secret

Payola.configure do |config|
  config.secret_key = Rails.application.secrets.stripe_api_key
  config.publishable_key = Rails.application.secrets.stripe_publishable_key

  config.default_currency = 'eur'

  config.subscribe('payola.subscription.active') do |sub|
    user = User.find_by(email: sub.email)
    user.update_attribute(:plan, Plan.find(sub.plan_id))
    #
    # if sub.is_a?(Payola::Subscription) && user.subscription.state == "active"
    #   raise "Error: This user already has an active <plan_class>."
    # end

    sub.owner = user
    sub.save!
  end
end
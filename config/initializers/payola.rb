Payola.configure do |payola|
  payola.secret_key = Rails.application.secrets.stripe_api_key
  payola.publishable_key = Rails.application.secrets.stripe_publishable_key

  payola.default_currency = 'eur'

  # before execute charge.
  # payola.charge_verifier = lambda do |sale, custom_data|
  #   if sale.product_type == 'Race'
  #     race = Race.find(sale.product_id)
  #     race.update_attribute(:status, 'started')
  #     race.update_attribute(:kind, 'pay_for_publish')
  #   end
  # end


  #
  # payola.subscribe 'payola.sale.finished' do |sale|
  # end

  #
  # payola.subscribe 'payola.race.sale.failed' do |sale|
  #   race = Race.find(sale.product_id)
  #   flash[:success] = "Pagamento fallito, prego riprova. #{sale.error}"
  #   raise 'Abbiamo avuto un problema nel pagamento'
  # end
  #

  payola.subscribe('payola.subscription.active') do |sub|
    user = User.find_by(email: sub.email)
    user.update_attribute(:plan, Plan.find(sub.plan_id))
  end


  # Payola.subscribe 'customer.subscription.deleted' do |event|
  #   sale = Sale.find_by(stripe_id: event.data.object.id)
  #   user = User.find_by(email: sale.email)
  #   UserMailer.expire_email(user).deliver
  #   user.destroy
  # end
end
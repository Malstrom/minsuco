class RegistrationsController < Devise::RegistrationsController

  def create
    super
    UserMailer.welcome(resource).deliver_later unless resource.invalid?
  end

end
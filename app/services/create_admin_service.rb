class CreateAdminService
  def call
    user = User.find_or_create_by!(email: Rails.application.secrets.admin_email) do |user|
        user.email = "igormir87@gmail.com"
        user.password = 12345678
        user.password_confirmation = 12345678
        user.rui = 7774545457777
        user.admin!
      end
  end
end

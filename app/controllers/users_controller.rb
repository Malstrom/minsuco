class UsersController < ApplicationController
  load_and_authorize_resource

  before_action :set_user, only: [:show, :edit, :update, :destroy, :intent]
  layout "application-main"

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html {redirect_to edit_user_path(@user), notice: I18n.t('flash.users.update.notice')}
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html {redirect_to root_path, notice: I18n.t('flash.users.delete.notice')}
      format.json { head :no_content }
    end
  end

  def plans
    @user = current_user
  end

  def friends
    @user = current_user

    @google_contacts = request.env['omnicontacts.contacts']

    unless @google_contacts.nil?
      @google_contacts.each do |contact|
        @user.friends.create(name:contact[:name], email:contact[:email]) if contact[:email]
      end
    end

    @contacts = @user.friends
  end

  def invite
    InviteMailer.invite_friends(params[:emails]).deliver_later

    render status: 200
  end

  def intent
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:rui, :name, :password, :plan, :role, :kind, :image, :fiscal_kind, :location, :password, :phone)
      # params.fetch(:user, {:name})
    end

  def flash_interpolation_options
    {resource_name: @user.name}
  end
end

class UsersController < ApplicationController
  load_and_authorize_resource

  before_action :set_user, only: [:show, :edit, :update, :intent]

  protect_from_forgery except: [:stop_tour, :active_tour]

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/1/edit
  def edit
    @invoices =  @user.get_invoices

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

  def plans
    @user = current_user
  end

  def intent
  end

  def theme
    current_user.update_attribute(:theme, params[:theme])
  end

  def stop_tour
    current_user.update_attribute(:tour, false)
  end

  def active_tour
    current_user.update_attribute(:tour, true)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:rui, :name, :company_name, :address, :address_num, :zip, :city, :fiscal_code, :password, :plan, :role, :kind, :image, :fiscal_kind, :city,
                                 :password, :phone, { interest_list: [] })
  end
end

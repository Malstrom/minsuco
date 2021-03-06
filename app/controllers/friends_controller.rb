class FriendsController < ApplicationController
  load_and_authorize_resource

  before_action :set_friend, only: [:show]

  # GET /friends
  # GET /friends.json
  def index
  end

  # GET /friends/1
  # GET /friends/1.json
  def show

  end

  # POST /friends
  # POST /friends.json
  def create
    @friend = Friend.find_or_create_by(friend_params)

    if @friend.save
      InviteMailer.new_request(@friend).deliver_later
      flash[:notice] = I18n.t('flash.friends.create.notice')
    else
      flash[:alert] = I18n.t('flash.friends.create.alert')
    end
    redirect_to request.referrer
  end

  def invites
    emails = params[:emails]

    # if user type email in form and that email do not in list of friends create new friend
    if emails.is_a? String
      emails = params[:emails].split(',')
      emails.each {|email| Friend.create(email:email) unless current_user.friends.include?(email)}
    end
    InviteMailer.invite_friends(emails.to_json).deliver_later

    flash[:notice] = I18n.t('flash.friends.invites.notice')

    redirect_to race_path(Race.find(params[:race_id]))
  end

  def invite_from_google
    current_user.update_attribute :redirect_path, "/races/#{params[:race_id]}?friend_modal=#{params[:friend_modal]}"
    redirect_to "/contacts/gmail"
  end

  def import
    @user = current_user

    @google_contacts = request.env['omnicontacts.contacts']

    unless @google_contacts.nil?
      friends = []
      @google_contacts.each do |contact|
        friends << @user.friends.build(name:contact[:name], email:contact[:email]) if contact[:email]
      end
      Friend.import friends    # or use import!
    end

    @contacts = @user.friends

    if @user.redirect_path
      redirect_to @user.redirect_path
      # @user.update_attribute(:redirect_path, nil)
    else
      redirect_to root_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friend
      @friend = Friend.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def friend_params
      params.require(:friend).permit(:name, :email)
    end
end

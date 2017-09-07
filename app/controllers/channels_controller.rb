class ChannelsController < ApplicationController
  load_and_authorize_resource

  before_action :set_channel, only: [:update]

  def update
    if @channel_subscription.update(channel_subscription_params)
      flash[:notice] = t('flash.channel_subscriptions.update.notice')
    else
      flash[:alert] = t('flash.channel_subscriptions.update.alert')
    end
    redirect_to user_edit_path(current_user)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_channel
    @channel = Channel.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def featured_channel_params
    params.require(:channel_subscription).permit(:email_muted, :in_app_muted)
  end
end

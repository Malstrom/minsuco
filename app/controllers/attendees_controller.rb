class AttendeesController < ApplicationController
  # load_and_authorize_resource

  before_action :set_attendee, only: [:update, :destroy]

  def index
    @attendees = current_user.attendees
  end

  def edit
  end

  # POST /attendees
  # POST /attendees.json
  def create
    race = Race.find(params[:race_id])
    @attendee = race.attendees.build(attendee_params)
    @attendee.user = current_user

    respond_to do |format|
      if @attendee.save
        format.html { redirect_to race_path(@attendee.race), notice: I18n.t('flash.attendees.create.notice') }
        format.json { render :show, status: :created, location: @attendee }
      else
        format.html { redirect_to race_path(@attendee.race),
                                  alert:  t("activerecord.errors.models.attendee.#{@attendee.errors.first[0]}", user_id: current_user.id) }
        format.json { render json: @attendee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attendees/1
  # PATCH/PUT /attendees/1.json
  def update
    if @attendee.update!(attendee_params)
      flash[:notice] = I18n.t('flash.attendees.update.notice')
    else
      flash[:alert] = I18n.t('flash.attendees.update.alert')
    end
    redirect_to race_path(@attendee.race)
  end

  # DELETE /attendees/1
  # DELETE /attendees/1.json
  def destroy
    if @attendee.destroy
      flash[:info] = I18n.t('flash.attendees.delete.notice')
    else
      @attendee.errors.each {|attr,msg| flash[:alert] = msg }
    end
    redirect_to race_path(@attendee.race)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attendee
      @attendee = Attendee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attendee_params
      params.require(:attendee).permit(:join_value, :status,
                                       pieces_attributes: [:id, :name, :value, :duration,:_destroy])
      # params.fetch(:attendee, {:join_value})
    end
end
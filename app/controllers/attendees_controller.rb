class AttendeesController < ApplicationController
  before_action :set_attendee, only: [:show, :edit, :update, :destroy]

  # GET /attendees
  # GET /attendees.json
  def index
    @attendees = current_user.attendees
  end

  # GET /attendees/1
  # GET /attendees/1.json
  def show
  end

  # GET /attendees/new
  def new
    @attendee = Attendee.new
  end

  # GET /attendees/1/edit
  def edit
  end

  # POST /attendees
  # POST /attendees.json
  def create
    @attendee = Race.find(params[:race_id]).attendees.build(user:current_user, join_value:params[:attendee][:join_value])

    respond_to do |format|
      if @attendee.save
        format.html { redirect_to race_path(@attendee.race), notice: I18n.t('flash.attendees.create.notice') }
        format.json { render :show, status: :created, location: @attendee }
      else
        format.html { redirect_to race_path(@attendee.race), alert: @attendee.errors.each {|attr,msg| flash[:alert] = msg } }
        format.json { render json: @attendee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attendees/1
  # PATCH/PUT /attendees/1.json
  def update
    @attendee.update(attendee_params)
    respond_with @attendee , location: -> { race_path(@attendee.race) }
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
      params.require(:attendee).permit(:join_value)
      # params.fetch(:attendee, {:join_value})
    end
end
class RacesController < ApplicationController
  layout 'application-main'

  before_action :set_race, only: [:show, :edit, :update, :destroy, :start, :pause, :pay_for_join, :pay_for_publish]

  # GET /races
  # GET /races.json
  def index
    @races = Race.where("starts_at <= ? AND ends_at >= ? AND status = ?", DateTime.now, DateTime.now, 'started').order('kind ASC')
    @featured_races = Race.joins(:featured_races).where("featured_races.starts_at <= ? AND featured_races.ends_at >= ? AND races.status = ?", DateTime.now, DateTime.now, 'started').order('races.kind ASC')
  end

  # GET /races/1
  # GET /races/1.json
  def show
  end

  # GET /races/new
  def new
    @race = Race.new
  end

  # GET /races/1/edit
  def edit
  end

  # POST /races
  # POST /races.json
  def create
    @race = Race.new(race_params)

    respond_to do |format|
      if @race.save
        format.html { redirect_to @race, notice: 'Race was successfully created.' }
        format.json { render :show, status: :created, location: @race }
      else
        format.html { render :new }
        format.json { render json: @race.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /races/1
  # PATCH/PUT /races/1.json
  def update
    respond_to do |format|
      if @race.update(race_params)
        format.html { redirect_to @race, notice: 'Race was successfully updated.' }
        format.json { render :show, status: :ok, location: @race }
      else
        format.html { render :edit }
        format.json { render json: @race.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /races/1
  # DELETE /races/1.json
  def destroy
    @race.destroy
    respond_to do |format|
      format.html { redirect_to races_url, notice: 'Race was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  # start race
  def start
    @race.update_attribute :status, 'started'

    redirect_to @race
  end

  # pause race
  def pause
    @race.update_attribute :status, 'paused'

    redirect_to @race
  end

  def pay_for_publish

    @race.update_attribute :kind, 'pay_for_publish'

    redirect_to @race
  end

  def pay_for_join

    @race.update_attribute :kind, 'pay_for_join'

    redirect_to @race
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_race
      if params[:id]
        @race = Race.find(params[:id])
      else
        @race = Race.find(params[:race_id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def race_params
      params.require(:race).permit(:name, :owner, :max_attendees, :category, :compensation_amount, :compensation_kind, :pieces_amount, :compensation_start_amount, :recipients, :race_value, :category)
    end
end

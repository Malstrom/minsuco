class RacesController < ApplicationController
  layout 'application-main'

  before_action :set_race, only: [:show, :edit, :update, :destroy,
                                  :start, :pause, :pay_for_join, :pay_for_publish, :join, :leave, :publish_new,
                                  :publish_check]

  # GET /races
  # GET /races.json
  def index
    sort = params[:sort] ? params[:sort] : 'kind'
    verse = params[:verse] ? params[:verse] : 'ASC'

    @races = Race.where("ends_at >= ? AND status = ?", DateTime.now, 'started').order("#{sort} #{verse}")
    @featured_races = Race.joins(:featured_races).where("featured_races.starts_at <= ? AND featured_races.ends_at >= ? AND races.status = ?", DateTime.now, DateTime.now, 'started').order("races.#{sort} #{verse}")
  end

  def user_races
    sort = params[:sort] ? params[:sort] : 'kind'
    verse = params[:verse] ? params[:verse] : 'ASC'

    @races = current_user.races

    # @races = Race.where("ends_at >= ? AND status = ? AND owner_id = ?", DateTime.now, 'started', current_user.id).order("#{sort} #{verse}")
    # @featured_races = Race.joins(:featured_races).where("featured_races.starts_at <= ? AND featured_races.ends_at >= ? AND races.status = ? AND owner_id = ?", DateTime.now, DateTime.now, 'started', current_user.id).order("races.#{sort} #{verse}")
  end

  def attendees
    @attendees = current_user.attendees
  end

  # GET /races/1
  # GET /races/1.json
  def show
  end


  # GET /races/new
  def new
    @race = Race.new

    race_values = %W(10000 50000 100000 75000 25000)
    # race_comp_kinds = %w(perc money)
    race_attendees = rand(10..50)
    compensation_start_amounts = %W(0 0 0 0 500 1000)

    def time_rand from = 0.0, to = Time.now
      Time.at(from + rand * (to.to_f - from.to_f))
    end

    @race.name = Faker::Space.star
    @race.description = Faker::Matz.quote
    @race.category = Category.find_by_name(:assicurazioni).children.last.children.sample
    @race.race_value = race_values.sample
    @race.pieces_amount = rand(5..50)
    @race.compensation_start_amount = compensation_start_amounts.sample
    @race.max_attendees = race_attendees
    @race.compensation_amount = rand(5..50)
    @race.kind = %w(pay_for_publish pay_for_join).sample
    @race.status = 'started'
    @race.recipients = %w(brokers agents all).sample
  end

  # GET /races/1/edit
  def edit
  end

  # POST /races
  # POST /races.json
  def create
    @race = current_user.races.build(race_params)

    @race.kind = 'pay_for_join' unless @race.kind # set race kind private by default
    @race.price = 2900
    @race.permalink = @race.name.parameterize
    @race.status = 'draft' # set race to status draft

    respond_to do |format|
      if @race.save!
        flash[:info] = "Gara salvata in bozza"
        format.html { redirect_to publish_race_path(@race) }
        format.json { render :show, status: :created, location: @race }
      else
        flash[:danger] = "Gara non salvata"
        format.html { render :new }
        format.json { render json: @race.errors, status: :unprocessable_entity }
      end
    end
  end

  def publish_new
  end

  def publish_create
    @race = Race.find(params[:id])

    if @race.publishable?
      @race.update_attribute(:kind, params[:race][:kind])

      flash[:success] = "Gara pubblicata con successo"
      redirect_to race_path @race
    else
      flash[:danger] = "La gara non puo essere pubblicata"
      redirect_to publish_race_path(@race)
    end
  end

  def publish_check
    flash[:success] = "Pagamento avvenuto con successo, Gara pubblicata"
    redirect_to race_path @race
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

  def join
    @attendee = @race.attendees.build

    @attendee.attendee = current_user


    if @attendee.save
      flash[:success] = "Sei dentro la gara"
    else
      @race.errors.full_messages.each do |error|
        flash[:danger] = "Attenzione!"
      end
    end


    redirect_to @race
  end

  def leave
    @attendee = @race.attendees.where(attendee:current_user).first

    @attendee.destroy

    redirect_to @race
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_race
      @race = Race.find(params[:id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def race_params
      params.require(:race).permit(:name, :description, :owner, :max_attendees, :compensation_amount,
                                   :pieces_amount, :compensation_start_amount, :recipients, :race_value, :category_id,
                                   :starts_at, :ends_at)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def featured_race_params
      params.require(:featured_race).permit(:race, :starts_at, :ends_at)
    end
end

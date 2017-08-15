class RacesController < ApplicationController
  # load_and_authorize_resource

  layout 'application-main'

  before_action :set_race, only: [:show, :edit, :update,
                                  :publish, :publish_check]

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

    @races = Race.where("owner_id = ?", current_user.id).order("#{sort} #{verse}")
    # @featured_races = Race.joins(:featured_races).where("owner_id = ?", DateTime.now, DateTime.now, 'started', current_user.id).order("races.#{sort} #{verse}")
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

    @race.name = Faker::Space.star
    @race.description = Faker::Matz.quote
    @race.category = Category.find_by_name(:assicurazioni).children.last.children.sample
    @race.race_value = %W(10000 50000 100000 75000 25000).sample
    @race.pieces_amount = rand(5..50)
    @race.compensation_start_amount = %W(0 0 0 0 500 1000).sample
    @race.max_attendees = rand(10..50)
    @race.compensation_amount = rand(5..50)
    @race.kind = %w(pay_for_publish pay_for_join).sample
    @race.status = 'started'
    @race.recipients = %w(brokers agents all).sample
  end

  def publish
  end

  # GET /races/1/edit
  def edit
  end

  # POST /races
  # POST /races.json
  def create
    @race = current_user.races.build(race_params)

    respond_to do |format|
      if @race.save
        format.html {redirect_to publish_race_path(@race), notice: I18n.t('flash.races.create.notice')}
        format.json { render :show, status: :created, location: @race }
      else
        format.html { render :new }
        format.json { render json: @race.errors, status: :unprocessable_entity }
      end
    end
  end

  def publish_check
    if @race.update(kind: params[:race] ? params[:race][:kind] : params[:kind])
      flash[:notice] = I18n.t('flash.races.publish_check.notice')
    else
      flash[:alert] = I18n.t('flash.races.publish_check.alert')
    end
    redirect_to race_path(@race)
  end

  # PATCH/PUT /races/1
  # PATCH/PUT /races/1.json
  def update
    if @race.update(race_params)
      flash[:notice] = I18n.t('flash.races.update.notice')
    else
      flash[:alert] = I18n.t('flash.races.update.alert')
    end
    redirect_to race_path(@race)
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
                                 :starts_at, :ends_at, :status)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def featured_race_params
    params.require(:featured_race).permit(:race, :starts_at, :ends_at)
  end

end

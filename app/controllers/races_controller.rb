class RacesController < ApplicationController
  # load_and_authorize_resource


  before_action :set_race, only: [:show, :edit, :update, :publish, :publish_check]

  # GET /races
  # GET /races.json
  def index
    if params[:category_id] and !params[:category_id].empty?
      category = Category.find(params[:category_id])
      @races = Race.by_category(category)
                   .not_expired.by_recipients(current_user.kind).order("ends_at ASC")
    elsif params[:commission] and !params[:commission].empty?
      @races = Race.not_expired.by_recipients(current_user.kind).order "commission #{params[:commission]}"
    elsif params[:kind] and !params[:kind].empty?
      @races = Race.not_expired.by_recipients(current_user.kind).order "kind #{params[:commission]}"
    elsif params[:ends_at] and !params[:ends_at].empty?
      @races = Race.not_expired.by_recipients(current_user.kind).order "ends_at #{params[:ends_at]}"
    else
      @races = Race.not_expired.by_recipients(current_user.kind)
    end
  end

  def user_races
    if params[:category_id] and !params[:category_id].empty?
      @races = Race.by_owner(current_user)
                   .by_category(Category.find(params[:category_id]).order("ends_at ASC}"))
    elsif params[:commission] and !params[:commission].empty?
      @races = Race.by_owner(current_user)
                   .order "commission #{params[:commission]}"
    elsif params[:kind] and !params[:kind].empty?
      @races = Race.by_owner(current_user)
                   .order "kind #{params[:commission]}"
    elsif params[:ends_at] and !params[:ends_at].empty?
      @races = Race.by_owner(current_user)
                   .order "ends_at #{params[:ends_at]}"
    else
      @races = Race.by_owner(current_user)
    end
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
    @race.min_pieces = rand(5..50)
    @race.compensation_start_amount = %W(0 0 0 0 500 1000).sample
    @race.max_attendees = rand(10..50)
    @race.commission = rand(5..50)
    @race.kind = %w(pay_for_publish pay_for_join).sample
    @race.status = 'started'
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
      current_user.reward.decrement_public_races if @race.pay_for_publish?
      if @race.started?
        flash[:notice] = I18n.t('flash.races.publish_check.notice')
      else
        flash[:alert] = I18n.t('flash.races.publish_check.alert')
      end
    else
      flash[:alert] = I18n.t('flash.races.publish_check.alert')
    end
    redirect_to race_path(@race)
  end

  # PATCH/PUT /races/1
  # PATCH/PUT /races/1.json
  def update
    respond_to do |format|
      if @race.update(race_params)
        format.html {redirect_to race_path(@race), notice: I18n.t('flash.races.update.notice')}
      else
        format.html { render :edit }
      end
    end

  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_race
    @race = Race.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def race_params
    params.require(:race).permit(:name, :description, :owner, :max_attendees, :commission,
                                 :min_pieces, :compensation_start_amount, :recipients, :race_value, :category_id,
                                 :starts_at, :ends_at, :status, :kind)
  end
end

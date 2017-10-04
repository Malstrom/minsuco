class RacesController < ApplicationController
  load_and_authorize_resource

  before_action :set_race, only: %i[show edit update publish publish_check like public_url]

  # GET /races
  # GET /races.json
  def index
    if params[:category_id] && !params[:category_id].empty?
      category = Category.find(params[:category_id])
      @races = Race.by_category(category)
                   .not_expired.by_recipients(current_user.kind).order('ends_at ASC')
    elsif params[:commission] && !params[:commission].empty?
      @races = Race.not_expired.by_recipients(current_user.kind).order "commission #{params[:commission]}"
    elsif params[:kind] && !params[:kind].empty?
      @races = Race.not_expired.by_recipients(current_user.kind).order "kind #{params[:commission]}"
    elsif params[:ends_at] && !params[:ends_at].empty?
      @races = Race.not_expired.by_recipients(current_user.kind).order "ends_at #{params[:ends_at]}"
    else
      @races = Race.not_expired.by_recipients(current_user.kind)
    end
  end

  def user_races
    @scope = params[:scope]
    if @scope
      @races = current_user.races.scope_races(@scope)
      if @races.empty?
        @races = current_user.races
      end
    end
  end

  # GET /races/1
  # GET /races/1.json
  def show
    # need for create nested form with pieces
    unless current_user.owner?(@race)
      @attendee = current_user.attendee(@race)
      unless @attendee
        @attendee = @race.attendees.build
        # @attendee.pieces.build
      end
    end
  end

  # GET /races/new
  def new
    @race = Race.new
    @race.description = Faker::Matz.quote
    @race.category = Category.find_by_name(:assicurazioni).children.last.children.sample
    @race.race_value = %w[10000 50000 100000 75000 25000].sample
    @race.compensation_start_amount = %w[0 0 0 0 500 1000].sample
    @race.kind = %w[open close].sample
    @race.status = 'started'

    @race.commissions.build(value:3,starts:0, ends:1)
    @race.commissions.build(value:1.5,starts:1, ends:5)
    @race.commissions.build(value:1,starts:5, ends:10)
    @race.commissions.build(value:0.5,starts:10, ends:15)
    @race.commissions.build(value:0.2,starts:15, ends:20)
  end

  #url allow access all users
  def public_url

  end

  def publish; end

  # GET /races/1/edit
  def edit; end

  # POST /races
  # POST /races.json
  def create
    @race = current_user.races.build(race_params)
    respond_to do |format|
      if @race.save
        format.html { redirect_to publish_race_path(@race), notice: I18n.t('flash.races.create.notice') }
        format.json { render :show, status: :created, location: @race }
      else
        format.html { render :new }
        format.json { render json: @race.errors, status: :unprocessable_entity }
      end
    end
  end

  def publish_check
    if @race.update(kind: params[:race] ? params[:race][:kind] : params[:kind])
      @race.update_attribute(:status, :started) if @race.publishable?
      if @race.started?
        if @race.open? && current_user.plan != Plan.find_by_stripe_id('pro_creator')
          @race.owner.reward.decrement_open_races
        end
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
        format.html { redirect_to race_path(@race), notice: I18n.t('flash.races.update.notice') }
      else
        format.html do
          redirect_to race_path(@race),
                      alert: t("activerecord.errors.models.race.#{@race.errors.first[0]}", user_id: current_user.id)
        end
      end
    end
  end

  def like
    if @race.add_like_of current_user
      render status: 200, json: @race.to_json
    else
      render status: 304, json: @race.to_json
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_race
    @race = Race.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def race_params
    params.require(:race).permit(:name, :description, :owner, :commission, :compensation_start_amount,
                                 :recipients, :race_value, :category_id, :starts_at, :ends_at, :status, :kind,
                                 commissions_attributes: [:id, :value, :starts, :ends, :_destroy])
  end
end

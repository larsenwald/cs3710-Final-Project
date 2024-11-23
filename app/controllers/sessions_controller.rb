class SessionsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_dm
  before_action :set_campaign
  before_action :set_session, only: [ :edit, :update, :destroy ]

  def new
    @campaign = Campaign.find(params[:campaign_id]) # Ensure campaign is loaded
    @session = @campaign.sessions.new              # Initialize session scoped to the campaign
  end

  def create
    @session = @campaign.sessions.new(session_params)
    if @session.save
      redirect_to campaign_path(@campaign), notice: "Session added successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @campaign = Campaign.find(params[:campaign_id])
    @session = @campaign.sessions.find(params[:id])
  end

  def update
    if @session.update(session_params)
      redirect_to campaign_path(@campaign), notice: "Session updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @session.destroy
    redirect_to campaign_path(@campaign), notice: "Session deleted successfully!"
  end

  private

  def require_dm
    redirect_to root_path, alert: "Only Dungeon Masters can perform this action." unless current_user.dm?
  end

  def set_campaign
    @campaign = Campaign.find(params[:campaign_id])
  end

  def set_session
    @session = @campaign.sessions.find(params[:id])
  end

  def session_params
    params.require(:session).permit(:date, :summary, :session_number)
  end
end

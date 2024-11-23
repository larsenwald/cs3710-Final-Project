class CampaignsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_dm, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :set_campaign, only: [ :show, :edit, :update, :destroy ]

  def show
    @sessions = @campaign.sessions.order(:session_number) # Ensure @sessions is always initialized
    @characters = @campaign.characters                   # Ensure @characters is initialized
  end

  def index
    @campaigns = if current_user.dm?
                   # Dungeon Masters see their own campaigns
                   current_user.campaigns
    else
                   # Players see campaigns they've joined
                   current_user.joined_campaigns
    end
  end

  def new
    @campaign = current_user.campaigns.new
  end

  def create
    @campaign = current_user.campaigns.new(campaign_params)
    if @campaign.save
      redirect_to @campaign, notice: "Campaign created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @campaign.update(campaign_params)
      redirect_to @campaign, notice: "Campaign updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @campaign.destroy
    redirect_to campaigns_path, notice: "Campaign deleted successfully!"
  end

  private

  def require_dm
    redirect_to root_path, alert: "Only Dungeon Masters can perform this action." unless current_user.dm?
  end

  def set_campaign
    @campaign = Campaign.find(params[:id])
  end

  def campaign_params
    params.require(:campaign).permit(:title, :description, :setting, :active)
  end
end

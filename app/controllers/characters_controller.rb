class CharactersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_player, only: [ :new, :create ]
  before_action :set_character, only: [ :edit, :update, :destroy ]

  def new
    @campaign = Campaign.find(params[:campaign_id]) # Fetch the campaign
    @character = @campaign.characters.new          # Initialize character tied to this campaign
  end

  def create
    @campaign = Campaign.find(params[:campaign_id]) # Fetch campaign
    @character = @campaign.characters.new(character_params) # Associate character with campaign
    @character.user = current_user # Associate character with the logged-in user

    if @character.save
      redirect_to campaign_path(@campaign), notice: "Character created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # `@character` is set in `set_character`
  end

  def update
    if @character.update(character_params)
      redirect_to campaign_path(@character.campaign), notice: "Character updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @character.destroy
    redirect_to campaign_path(@character.campaign), notice: "Character deleted successfully!"
  end

  private

  def require_player
    redirect_to root_path, alert: "Only Players can create characters." unless current_user.player?
  end

  def set_character
    @campaign = Campaign.find(params[:campaign_id]) # Fetch campaign from nested route
    @character = @campaign.characters.find(params[:id]) # Fetch character scoped to the campaign
  end

  def character_params
    params.require(:character).permit(:name, :character_class, :level, :backstory, :campaign_id)
  end
end

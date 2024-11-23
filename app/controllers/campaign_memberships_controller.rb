class CampaignMembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_player

  def new
    @campaign_membership = CampaignMembership.new
  end

  def create
    @campaign = Campaign.find_by(access_code: params[:access_code])
    if @campaign.nil?
      redirect_to new_campaign_membership_path, alert: "Invalid campaign code."
    elsif @campaign.players.include?(current_user)
      redirect_to campaigns_path, alert: "You are already a member of this campaign."
    else
      @campaign.players << current_user
      redirect_to campaigns_path, notice: "Successfully joined the campaign!"
    end
  end

  def destroy
    @campaign = Campaign.find(params[:id])
    membership = @campaign.campaign_memberships.find_by(user: current_user)
    if membership
      membership.destroy
      redirect_to campaigns_path, notice: "Successfully left the campaign."
    else
      redirect_to campaigns_path, alert: "You are not a member of this campaign."
    end
  end

  private

  def require_player
    redirect_to root_path, alert: "Only Players can join or leave campaigns." unless current_user.player?
  end
end

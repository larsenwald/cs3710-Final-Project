class CampaignsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_dm, only: [ :new, :create ]

  private

  def require_dm
    unless current_user&.DM?
      redirect_to root_path, alert: "Only Dungeon Masters can create campaigns."
    end
  end
end

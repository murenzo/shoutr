class DashboardsController < ApplicationController
  def show
    @shouts = current_user.timeline_shouts
  end
end
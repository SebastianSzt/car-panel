module Admin
  class DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :admin_only

    def index
      @brands = Brand.includes(:models).all
      @brand = Brand.new
      @model = Model.new
    end

    private

    def admin_only
      if current_user.nil? || !current_user.admin?
        redirect_to(root_path, alert: "Not authorized")
      end
    end
  end
end

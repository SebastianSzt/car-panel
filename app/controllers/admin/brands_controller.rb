module Admin
  class BrandsController < ApplicationController
    before_action :authenticate_user!
    before_action :admin_only

    def new
      @brand = Brand.new
    end

    def create
      @brand = Brand.new(brand_params)
      if @brand.save
        redirect_to admin_root_path, notice: "Brand was successfully created."
      else
        render :new
      end
    end

    def destroy
      @brand = Brand.find(params[:id])
      @brand.destroy
      redirect_to admin_root_path, notice: "Brand was successfully destroyed."
    end

    def import
      # Placeholder for the import logic
      redirect_to admin_root_path, notice: "Brands were successfully imported."
    end

    private

    def brand_params
      params.require(:brand).permit(:name)
    end

    def admin_only
      if current_user.nil? || !current_user.admin?
        redirect_to(root_path, alert: "Not authorized")
      end
    end
  end
end

module Admin
  class ModelsController < ApplicationController
    before_action :authenticate_user!
    before_action :admin_only
    before_action :set_brand

    def new
      @model = @brand.models.new
    end

    def create
      @model = @brand.models.new(model_params)
      if @model.save
        redirect_to admin_root_path, notice: "Model was successfully created."
      else
        render :new
      end
    end

    def destroy
      @model = @brand.models.find(params[:id])
      @model.destroy
      redirect_to admin_root_path, notice: "Model was successfully destroyed."
    end

    private

    def set_brand
      @brand = Brand.find(params[:brand_id])
    end

    def model_params
      params.require(:model).permit(:name, :year)
    end

    def admin_only
      if current_user.nil? || !current_user.admin?
        redirect_to(root_path, alert: "Not authorized")
      end
    end
  end
end

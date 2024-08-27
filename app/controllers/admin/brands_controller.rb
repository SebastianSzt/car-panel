# app/controllers/admin/brands_controller.rb
class Admin::BrandsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only
  before_action :set_brand, only: %i[ show edit update destroy ]

  # GET /admin/brands or /admin/brands.json
  def index
    @brands = Brand.page(params[:page]).per(10)
  end

  # GET /admin/brands/1 or /admin/brands/1.json
  def show
    @brand = Brand.find(params[:id])
    @models = @brand.models.page(params[:page]).per(10)
  end

  # GET /admin/brands/new
  def new
    @brand = Brand.new
  end

  # GET /admin/brands/1/edit
  def edit
  end

  # POST /admin/brands or /admin/brands.json
  def create
    @brand = Brand.new(brand_params)

    respond_to do |format|
      if @brand.save
        format.html { redirect_to admin_brand_url(@brand), notice: "Brand was successfully created." }
        format.json { render :show, status: :created, location: @brand }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/brands/1 or /admin/brands/1.json
  def update
    respond_to do |format|
      if @brand.update(brand_params)
        format.html { redirect_to admin_brand_url(@brand), notice: "Brand was successfully updated." }
        format.json { render :show, status: :ok, location: @brand }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/brands/1 or /admin/brands/1.json
  def destroy
    @brand = set_brand
    @brand.destroy!

    respond_to do |format|
      format.html { redirect_to admin_brands_url, notice: "Brand was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brand
      @brand = Brand.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def brand_params
      params.require(:brand).permit(:name)
    end

    def admin_only
      redirect_to(root_path, alert: "Not authorized") unless current_user.admin?
    end
end

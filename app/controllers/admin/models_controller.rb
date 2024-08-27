class Admin::ModelsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only
  before_action :set_model, only: %i[ show edit update destroy ]
  before_action :set_brand

  # GET /admin/brands/:brand_id/models or /admin/brands/:brand_id/models.json
  def index
    @models = Model.all
    @models.each do |model|
      model.brand_name = Brand.find(model.brand_id).name
    end
  end

  # GET /admin/brands/:brand_id/models/1 or /admin/brands/:brand_id/models/1.json
  def show
    @model = Model.find(params[:id])
    @brand = Brand.find(@model.brand_id)
    @model.brand_name = @brand.name
  end

  # GET /admin/brands/:brand_id/models/new
  def new
    @model = @brand.models.build
  end

  # GET /admin/brands/:brand_id/models/1/edit
  def edit
    @model.brand_name = Brand.find(@model.brand_id).name
  end

  # POST /admin/brands/:brand_id/models or /admin/brands/:brand_id/models.json
  def create
    @model = @brand.models.build(model_params)

    respond_to do |format|
      if @model.save
        format.html { redirect_to admin_brand_model_url(@brand, @model), notice: "Model was successfully created." }
        format.json { render :show, status: :created, location: @model }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @model.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/brands/:brand_id/models/1 or /admin/brands/:brand_id/models/1.json
  def update
    respond_to do |format|
      if @model.update(model_params)
        format.html { redirect_to admin_brand_model_url(@brand, @model), notice: "Model was successfully updated." }
        format.json { render :show, status: :ok, location: @model }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @model.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/brands/:brand_id/models/1 or /admin/brands/:brand_id/models/1.json
  def destroy
    @model.destroy!

    respond_to do |format|
      format.html { redirect_to admin_brand_url(@brand), notice: "Model was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_model
      @model = Model.find(params[:id])
    end

    def set_brand
      @brand = Brand.find(params[:brand_id])
    end

    # Only allow a list of trusted parameters through.
    def model_params
      params.require(:model).permit(:name, :year, :brand_name)
    end

    def admin_only
      unless current_user&.admin?
        redirect_to root_path, alert: "You are not allowed to access this page."
      end
    end
end

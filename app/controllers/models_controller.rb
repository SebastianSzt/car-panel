class ModelsController < ApplicationController
  before_action :user_only, only: [ :edit, :update ]
  before_action :admin_only, only: [ :new, :create, :destroy ]
  before_action :set_model, only: %i[ show edit update destroy ]
  before_action :set_brand

  # GET /brands/:brand_id/models or /brands/:brand_id/models.json
  def index
    @models = Model.where(brand_id: params[:brand_id])
    @models.each do |model|
      model.brand_name = Brand.find(model.brand_id).name
    end
  end

  # GET /brands/:brand_id/models/1 or /brands/:brand_id/models/1.json
  def show
    @model = Model.find(params[:id])
    @brand = Brand.find(@model.brand_id)
    @model.brand_name = @brand.name
  end

  # GET /brands/:brand_id/models/new
  def new
    @model = Model.new
  end

  # GET /brands/:brand_id/models/1/edit
  def edit
  end

  # POST /brands/:brand_id/models or /brands/:brand_id/models.json
  def create
    @model = Model.new(model_params)
    @model.brand_id = params[:brand_id]

    respond_to do |format|
      if @model.save
        format.html { redirect_to brand_model_path(@model.brand, @model), notice: "Model was successfully created." }
        format.json { render :show, status: :created, location: @model }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @model.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /brands/:brand_id/models/1 or /brands/:brand_id/models/1.json
  def update
    respond_to do |format|
      if @model.update(model_params)
        format.html { redirect_to brand_model_path(@model.brand, @model), notice: "Model was successfully updated." }
        format.json { render :show, status: :ok, location: @model }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @model.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /brands/:brand_id/models/1 or /brands/:brand_id/models/1.json
  def destroy
    @model.destroy
    respond_to do |format|
      format.html { redirect_to brand_models_path(@model.brand), notice: "Model was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_model
    @model = Model.find(params[:id])
  end

  def set_brand
    @brand = Brand.find(params[:brand_id])
  end

  def model_params
    params.require(:model).permit(:name, :year)
  end

  def user_only
    redirect_to(root_path, alert: "Not authorized") unless user_signed_in?
  end

  def admin_only
    if current_user.nil? || !current_user.admin?
      redirect_to(root_path, alert: "Not authorized")
    end
  end
end

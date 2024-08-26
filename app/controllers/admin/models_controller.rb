class Admin::ModelsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only
  before_action :set_model, only: %i[ show edit update destroy ]

  # GET /models or /models.json
  def index
    @models = Model.all
    @models.each do |model|
      model.brand_name = Brand.find(model.brand_id).name
    end
  end

  # GET /models/1 or /models/1.json
  def show
    @model.brand_name = Brand.find(@model.brand_id).name
  end

  # GET /models/new
  def new
    @model = Model.new
  end

  # GET /models/1/edit
  def edit
    @model.brand_name = Brand.find(@model.brand_id).name
  end

  # POST /models or /models.json
  def create
    params = process_params

    @model = Model.new(params)

    respond_to do |format|
      if @model.save
        format.html { redirect_to model_url(@model), notice: "Model was successfully created." }
        format.json { render :show, status: :created, location: @model }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @model.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /models/1 or /models/1.json
  def update
    params = process_params

    respond_to do |format|
      if @model.update(params)
        format.html { redirect_to model_url(@model), notice: "Model was successfully updated." }
        format.json { render :show, status: :ok, location: @model }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @model.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /models/1 or /models/1.json
  def destroy
    @model.destroy!

    respond_to do |format|
      format.html { redirect_to models_url, notice: "Model was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_model
      @model = Model.find(params[:id])
    end

    def process_params
      brand = Brand.find_by(name: params[:model][:brand_name])
      return nil if brand.nil?

      processed_params = model_params.dup
      processed_params.delete(:brand_name)
      processed_params.merge!(brand_id: brand.id)
      processed_params
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

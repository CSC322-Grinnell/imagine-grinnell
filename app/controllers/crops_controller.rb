class CropsController < ApplicationController
  before_action :set_crop, only: [:show, :edit, :update, :destroy]

  # GET /crops
  # GET /crops.json
  def index
    @crops = Crop.all
  end

  # GET /crops/1
  # GET /crops/1.json
  def show; end

  # GET /crops/new
  def new
    @crop = Crop.new
  end

  # GET /crops/1/edit
  def edit; end

  # POST /crops
  # POST /crops.json
  def create
    @crop = Crop.new(crop_params)

    respond_to do |format|
      if @crop.save
        format.html { redirect_to @crop, notice: 'Crop was successfully created.' }
        format.json { render :show, status: :created, location: @crop }
      else
        format.html { render :new }
        format.json { render json: @crop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /crops/1
  # PATCH/PUT /crops/1.json
  def update
    respond_to do |format|
      if @crop.update(crop_params)
        format.html { redirect_to @crop, notice: 'Crop was successfully updated.' }
        format.json { render :show, status: :ok, location: @crop }
      else
        format.html { render :edit }
        format.json { render json: @crop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /crops/1
  # DELETE /crops/1.json
  def destroy
    @crop.destroy
    respond_to do |format|
      format.html { redirect_to crops_url, notice: 'Crop was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_crop
    @crop = Crop.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def crop_params
    params.require(:crop).permit(:produce, :garden_id, :planted_at, :description)
  end
end

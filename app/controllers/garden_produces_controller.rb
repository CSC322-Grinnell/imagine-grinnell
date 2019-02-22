class GardenProducesController < ApplicationController
  before_action :set_garden_produce, only: [:show, :edit, :update, :destroy]

  # GET /garden_produces
  # GET /garden_produces.json
  def index
    @garden_produces = GardenProduce.all
  end

  # GET /garden_produces/1
  # GET /garden_produces/1.json
  def show
  end

  # GET /garden_produces/new
  def new
    @garden_produce = GardenProduce.new
  end

  # GET /garden_produces/1/edit
  def edit
  end

  # POST /garden_produces
  # POST /garden_produces.json
  def create
    @garden_produce = GardenProduce.new(garden_produce_params)

    respond_to do |format|
      if @garden_produce.save
        format.html { redirect_to @garden_produce, notice: 'Garden produce was successfully created.' }
        format.json { render :show, status: :created, location: @garden_produce }
      else
        format.html { render :new }
        format.json { render json: @garden_produce.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /garden_produces/1
  # PATCH/PUT /garden_produces/1.json
  def update
    respond_to do |format|
      if @garden_produce.update(garden_produce_params)
        format.html { redirect_to @garden_produce, notice: 'Garden produce was successfully updated.' }
        format.json { render :show, status: :ok, location: @garden_produce }
      else
        format.html { render :edit }
        format.json { render json: @garden_produce.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /garden_produces/1
  # DELETE /garden_produces/1.json
  def destroy
    @garden_produce.destroy
    respond_to do |format|
      format.html { redirect_to garden_produces_url, notice: 'Garden produce was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_garden_produce
      @garden_produce = GardenProduce.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def garden_produce_params
      params.require(:garden_produce).permit(:prediction_date, :readiness)
    end
end

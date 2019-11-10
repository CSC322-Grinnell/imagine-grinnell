class GardenProducesController < ApplicationController
  before_action :set_garden_produce, only: [:show, :edit, :update, :destroy]
  # GET /garden_produces
  def index
    @garden_produces = GardenProduce.all

    @garden_produces.each do |gp|
      @garden_produce = gp
      calculate_readiness
    end

    render json: @garden_produces
  end

  # GET /garden_produces/1
  def show
    calculate_readiness
    render json: @garden_produce
  end
  # POST /garden_produces
  skip_before_action :verify_authenticity_token
  def create
    @garden_produce = GardenProduce.new(garden_produce_params)
    @produce = Produce.find(@garden_produce.produce_id)

    planted = Date.parse(@garden_produce.planted_at)
    dur = @produce.duration.to_i
    available = planted + dur

    @garden_produce.available_at = available.to_s
    @garden_produce.readiness = 0

    if @garden_produce.save
      render json: @garden_produce, status: :created
    else
      render json: @garden_produce.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /garden_produces/1
  def update
    if @garden_produce.update(garden_produce_params)
      render json: @garden_produce, status: :ok
    else
      render json: @garden_produce.errors, status: :unprocessable_entity
    end
  end

  # DELETE /garden_produces/1
  def destroy
    @garden_produce.destroy
    if @garden_produce.destroy
      head :no_content, status: :ok
    else
      render json: @garden_produce.errors, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_garden_produce
    @garden_produce = GardenProduce.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def garden_produce_params
    params.require(:garden_produce).permit(:garden_id, :produce_id, :available_at, :readiness, :planted_at)
  end

  def calculate_readiness
    @produce = Produce.find(@garden_produce.produce_id)
    limit = (0.8 * @produce.duration.to_i).round
    available = Date.parse(@garden_produce.available_at)
    if available < Date.today
      @garden_produce.readiness = 2  # ready
    elsif (available - limit) < Date.today
      @garden_produce.readiness = 1  # almost ready
    end
  end
end

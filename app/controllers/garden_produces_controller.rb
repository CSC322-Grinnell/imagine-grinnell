class GardenProducesController < ApplicationController
  before_action :set_garden_produce, only: [:show, :edit, :update, :destroy]

  # GET /garden_produces
  def index
    @garden_produces = GardenProduce.all
    render json: @garden_produces
  end

  # GET /garden_produces/1
  def show
    render json: @garden_produce
  end

  # POST /garden_produces
  skip_before_action :verify_authenticity_token
  def create
    @garden_produce = GardenProduce.new(garden_produce_params)
    @produce = Produce.find(@garden_produce.produce_id)
    
    dur = @produce.duration.to_i
    available = @garden_produce.created_at.to_date
     
    #@garden_produce.available_at = available.to_s

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
end

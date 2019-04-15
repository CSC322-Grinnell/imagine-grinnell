class GardensController < ApplicationController
  before_action :set_garden, only: [:show, :edit, :update, :destroy]

  # GET /gardens
  def index
    @gardens = Garden.all
    render json: @gardens
  end

  # GET /gardens/1
  def show
    render json: @garden
  end

  # POST /gardens
  skip_before_action :verify_authenticity_token
  def create
    @garden = Garden.new(garden_params)

    if @garden.save
      render json: @garden, status: :created
    else
      render json: @garden.errors, status: :unprocessable_entity
    end

  end

  # PATCH/PUT /gardens/1
  def update      
     if @garden.update(garden_params)        
        render json: @garden, status: :ok
     else        
        render json: @garden.errors, status: :unprocessable_entity      
     end
  end

  # DELETE /gardens/1
  def destroy
    @garden.destroy
    if @garden.destroy
      head :no_content, status: :ok
    else
      render json: @garden.errors, status: :unprocessable_entity
    end    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_garden
      @garden = Garden.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white garden through.
    def garden_params
      params.require(:garden).permit(:name, :address, :lat, :long, :contact_name, :contact_number, :email, :image, :notes)
    end
end

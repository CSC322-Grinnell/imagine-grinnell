class ProducesController < ApplicationController
  before_action :set_produce, only: [:show, :edit, :update, :destroy]

  # GET /produces
  def index
    @produces = Produce.all
    render json: @produces
  end

  # GET /produces/1
  def show
    render json: @produce
  end

  # POST /produces
  skip_before_action :verify_authenticity_token
  def create
    @produce = Produce.new(produce_params)

    if @produce.save
      render json: @produce, status: :created
    else
      render json: @produce.errors, status: :unprocessable_entity
    end

  end

  # PATCH/PUT /produces/1
  def update      
     if @produce.update(produce_params)        
        render json: @produce, status: :ok
     else        
        render json: @produce.errors, status: :unprocessable_entity      
     end
  end

  # DELETE /produces/1
  def destroy
    @produce.destroy
    if @produce.destroy
      head :no_content, status: :ok
    else
      render json: @produce.errors, status: :unprocessable_entity
    end    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_produce
      @produce = Produce.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white produce through.
    def produce_params
      params.require(:produce).permit(:name, :duration)
    end
end

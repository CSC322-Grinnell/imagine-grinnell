class ProducesController < ApplicationController
  before_action :set_produce, only: [:show, :edit, :update, :destroy]

  # GET /produces
  # GET /produces.json
  def index
    @produces = Produce.all
  end

  # GET /produces/1
  # GET /produces/1.json
  def show
  end

  # GET /produces/new
  def new
    @produce = Produce.new
  end

  # GET /produces/1/edit
  def edit
  end

  # POST /produces
  # POST /produces.json
  def create
    @produce = Produce.new(produce_params)

    respond_to do |format|
      if @produce.save
        format.html { redirect_to @produce, notice: 'Produce was successfully created.' }
        format.json { render :show, status: :created, location: @produce }
      else
        format.html { render :new }
        format.json { render json: @produce.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /produces/1
  # PATCH/PUT /produces/1.json
  def update
    respond_to do |format|
      if @produce.update(produce_params)
        format.html { redirect_to @produce, notice: 'Produce was successfully updated.' }
        format.json { render :show, status: :ok, location: @produce }
      else
        format.html { render :edit }
        format.json { render json: @produce.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /produces/1
  # DELETE /produces/1.json
  def destroy
    @produce.destroy
    respond_to do |format|
      format.html { redirect_to produces_url, notice: 'Produce was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_produce
      @produce = Produce.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def produce_params
      params.require(:produce).permit(:name)
    end
end

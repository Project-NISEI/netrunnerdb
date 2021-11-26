class LegalityTypesController < ApplicationController
  before_action :set_legality_type, only: [:show, :edit, :update, :destroy]

  # GET /legality_types
  # GET /legality_types.json
  def index
    @legality_types = LegalityType.all
  end

  # GET /legality_types/1
  # GET /legality_types/1.json
  def show
  end

  # GET /legality_types/new
  def new
    @legality_type = LegalityType.new
  end

  # GET /legality_types/1/edit
  def edit
  end

  # POST /legality_types
  # POST /legality_types.json
  def create
    @legality_type = LegalityType.new(legality_type_params)

    respond_to do |format|
      if @legality_type.save
        format.html { redirect_to @legality_type, notice: 'Legality type was successfully created.' }
        format.json { render :show, status: :created, location: @legality_type }
      else
        format.html { render :new }
        format.json { render json: @legality_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /legality_types/1
  # PATCH/PUT /legality_types/1.json
  def update
    respond_to do |format|
      if @legality_type.update(legality_type_params)
        format.html { redirect_to @legality_type, notice: 'Legality type was successfully updated.' }
        format.json { render :show, status: :ok, location: @legality_type }
      else
        format.html { render :edit }
        format.json { render json: @legality_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /legality_types/1
  # DELETE /legality_types/1.json
  def destroy
    @legality_type.destroy
    respond_to do |format|
      format.html { redirect_to legality_types_url, notice: 'Legality type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_legality_type
      @legality_type = LegalityType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def legality_type_params
      params.require(:legality_type).permit(:name, :code)
    end
end

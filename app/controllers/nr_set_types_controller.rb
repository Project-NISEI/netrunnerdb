class NrSetTypesController < ApplicationController
  def index
    @nr_set_types = NrSetType.all.order(:name).paginate(page: params[:page])
  end

  def show
    @nr_set_type = NrSetType.find(params[:id])
    return if @nr_set_type.present?

    redirect_to nr_set_types_path
  end

  def new
    @nr_set_type = NrSetType.new
  end

  def edit
    @nr_set_type = NrSetType.find(params[:id])
    return if @nr_set_type.present?

    redirect_to nr_set_types_path
  end

  def create
    @nr_set_type = NrSetType.new(nr_set_type_params)
    if @nr_set_type.save
      flash[:info] = 'Set created'
      redirect_to @nr_set_type
    else
      render 'new'
    end
  end

  def update
    @nr_set_type = NrSetType.find(params[:id])
    if @nr_set_type.update(nr_set_type_params)
      flash[:success] = 'Set updated'
      redirect_to @nr_set_type
    else
      render 'edit'
    end
  end

  def destroy
    NrSetType.find(params[:id]).destroy
    flash[:success] = 'Set deleted'
    redirect_to cycles_url
  end

  private

  def set_nr_set_type
    @nr_set_type = NrSetType.find(params[:id])
  end

  def nr_set_type_params
    params.require(:nr_set_type).permit(:name, :description)
  end
end

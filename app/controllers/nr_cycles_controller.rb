class NrCyclesController < ApplicationController
  before_action :admin_user, only: %i[index edit update destroy show create new]

  def index
    @nr_cycles = NrCycle.all.order(:name)
  end

  def show
    @nr_cycle = NrCycle.find(params[:id])
    return if @nr_cycle.present?

    redirect_to cycles_path
  end

  def new
    @nr_cycle = NrCycle.new
  end

  def edit
    @nr_cycle = NrCycle.find(params[:id])
    return if @nr_cycle.present?

    redirect_to cycles_path
  end

  def create
    @nr_cycle = NrCycle.new(nr_cycle_params)
    if @nr_cycle.save
      flash[:info] = 'Cycle created'
      redirect_to @nr_cycle
    else
      render 'new'
    end
  end

  def update
    @nr_cycle = NrCycle.find(params[:id])
    if @nr_cycle.update(cycle_params)
      flash[:success] = 'Cycle updated'
      redirect_to @nr_cycle
    else
      render 'edit'
    end
  end

  def destroy
    NrCycle.find(params[:id]).destroy
    flash[:success] = 'Cycle deleted'
    redirect_to cycles_url
  end

  private

  def set_cycle
    @nr_cycle = NrCycle.find(params[:id])
  end

  def cycle_params
    params.require(:cycle).permit(:code, :name)
  end

  def admin_user
    redirect_to(root_url) unless current_user&.admin?
  end
end

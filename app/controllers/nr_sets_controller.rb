class NrSetsController < ApplicationController
  def index
    @nr_sets = NrSet.includes(:nr_set_type, :nr_cycle)
                    .all
                    .order(date_release: :desc)
  end

  def show
    @printings = Printing.includes(nr_set: [:nr_cycle],
                                   card: %i[side faction card_type subtype_relations])
                         .where(nr_sets: { code: params[:code] })
                         .merge(Printing.order(position: :asc))

    redirect_to nr_sets_path unless @printings.present?
  end

  def new
    @nr_set = NrSet.new
  end

  def edit
    @nr_set = NrSet.find_by(code: params[:code])
    return if @nr_set.present?

    redirect_to nr_sets_path
  end

  def create
    @nr_set = NrSet.new(nr_set_params)
    if @nr_set.save
      flash[:info] = 'Set created'
      redirect_to @nr_set
    else
      render 'new'
    end
  end

  def update
    @nr_set = NrSet.find_by(code: params[:id])
    if @nr_set.update(nr_set_params)
      flash[:success] = 'Set updated'
      redirect_to @nr_set
    else
      render 'edit'
    end
  end

  def destroy
    NrSet.find_by(code: params[:code]).destroy
    flash[:success] = 'Set deleted'
    redirect_to nr_sets_url
  end

  private

  def set_nr_set
    @nr_set = NrSet.find(params[:id])
  end

  def nr_set_params
    params.require(:nr_set).permit(:code, :name, :nr_cycle_id, :date_release, :size,
                                   :nr_set_type_id)
  end
end

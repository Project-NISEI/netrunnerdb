class PrintingsController < ApplicationController
  def show
    nr_set = params[:nr_set]
    position = params[:position]
    code = params[:code]

    s = NrSet.find_by(code: nr_set)
    if s.present?
      @printing = Printing.find_by(nr_set_id: s.id, position: position)
      # @card = @printing.card if @printing.present?
    end

    return unless @printing.present? && @printing.card.code != code

    redirect_to "/card/#{nr_set}/#{position}/#{@printing.card.code}", status: 301
  end
end

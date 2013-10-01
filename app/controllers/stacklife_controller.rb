class StacklifeController < ApplicationController
  helper_method :permitted_params

  def show
    respond_to do |format|
      format.json do
        @search = Search.new *permitted_params.search
        @items = @search.result permitted_params.args
        render json: @items
      end
      format.html do
        params[:spec_type] = 'Book'
        @search = Search.new *permitted_params.search
        render :show
      end
    end
  end

  private

    def permitted_params
      @permitted_params ||= PermittedParams.new(params)
    end

end
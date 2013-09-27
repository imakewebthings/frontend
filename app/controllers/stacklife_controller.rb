class StacklifeController < ApplicationController
  helper_method :permitted_params

  def show
    respond_to do |format|
      @search = Search.new *permitted_params.search
      format.json do
        @items = @search.result permitted_params.args
        render json: @items
      end
      format.html { render :show }
    end
  end

  private

    def permitted_params
      @permitted_params ||= PermittedParams.new(params)
    end

end
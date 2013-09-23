class StacklifeController < ApplicationController
  helper_method :permitted_params

  def show
    @search = Search.new *permitted_params.search
    @items = @search.result permitted_params.args
  end

  private

    def permitted_params
      @permitted_params ||= PermittedParams.new(params)
    end

end
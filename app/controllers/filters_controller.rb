class FiltersController < ApplicationController
  respond_to :json

  def set_filter
    filter = current_user.get_filter(filter_type) || current_user.create_filter(filter_type)
    filter.update filter_params
    render text: "success"
  end

  def success
    render text: "success"
  end

  private

  def filter_params
    params.require(:filter).require(:params)
  end

  def filter_type
    params.require(:filter).require(:type)
  end


end

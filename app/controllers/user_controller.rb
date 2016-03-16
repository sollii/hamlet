class UserController < ApplicationController
  respond_to :json

  def get_listings
    @user = User.where(listing_params).first
    if @user
      @listings = RablRails.render @user.filtered_listings, 'index', view_path: 'app/views/homes', format: :json
      respond_with(@homes)
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.

  def listing_params
    {id: params.require(:id)}
  end
end

class UserController < ApplicationController
  respond_to :json

  def get_listings
    @user = User.where(listing_params).first
    if @user
      @listings = RablRails.render @user.filtered_listings, 'index', view_path: 'app/views/homes', format: :json
      respond_with(@homes)
    end
  end

  def update
    User.where(id: user_id).update update_user_params
    success
  end

  def success
    respond_with :ok
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.

  def user_id
    params.require(:id)
  end

  def update_user_params
    params.require(:user).permit(:name)
  end
end

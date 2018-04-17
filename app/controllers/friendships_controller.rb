class FriendshipsController < ApplicationController
  def create
    if !(current_user.friends.exists?(params[:friend_id]))
      @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
      if @friendship.save
        flash[:notice] = "Added friend."
        redirect_to user_url(current_user)
      else
        flash[:error] = "Error occurred when adding friend."
        redirect_to users_url
      end
    else
      flash[:notice] = "You have already added this user as a friend."
      redirect_to users_url
    end
  end

  def destroy
    # byebug
    @friendship = current_user.friendships.find(params[:friend_id])
    @friendship.destroy
    flash[:notice] = "Successfully deleted friend."
    redirect_to user_url
  end
end

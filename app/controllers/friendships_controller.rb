class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      flash[:notice] = "Added friend."
      redirect_to user_url(current_user)
    else
      flash[:error] = "Error occurred when adding friend."
      redirect_to users_url
    end
  end

  def destroy
    friend = User.find(params[:id])
    current_user.friends.delete(friend)
    flash[:notice] = "Successfully unfollowed #{friend.username}."
    redirect_to current_user
  end
end

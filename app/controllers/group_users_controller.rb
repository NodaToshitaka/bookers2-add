class GroupUsersController < ApplicationController

  def create
    @group = Group.find(params[:group_id])
    GroupUser.create(user_id: current_user.id, group_id: @group.id)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @group = Group.find(params[:group_id])
    GroupUser.find_by(user_id: current_user.id, group_id: @group.id).destroy
    redirect_back(fallback_location: root_path)
  end

end

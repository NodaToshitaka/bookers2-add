class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      GroupUser.create(user_id: current_user.id, group_id: @group.id)
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def index
    @groups = Group.all
  end
  def show
    @group = Group.find(params[:id])
    @owner = User.find_by(id: @group.owner_id)
  end

  def edit
    @group = Group.find(params[:id])
    redirect_to groups_path unless current_user.id == @group.owner_id
  end

  def update
    @group = Group.find(params[:id])
    if @groupe.update(group_params)
      redirect_to group_path(@group)
    else
      render :edit
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :intorduction, :image_id)
  end
end

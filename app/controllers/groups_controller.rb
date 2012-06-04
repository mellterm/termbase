class GroupsController < ApplicationController
  
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @access_code= @group.access_code
  end

  def new
    @group = Group.new
    @owner_profiles = Profile.find_all_by_user_id(current_user)
  end

  def create
    #use user-like login with user name + secure_code
    @group = Group.new(params[:group])
    if @group.save
      redirect_to @group, :notice => "Successfully created group."
    else
      render :action => 'new'
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(params[:group])
      redirect_to @group, :notice  => "Successfully updated group."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to groups_url, :notice => "Successfully destroyed group."
  end
  

  
  
end

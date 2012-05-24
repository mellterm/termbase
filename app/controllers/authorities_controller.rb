class AuthoritiesController < ApplicationController
  before_filter :setup_translation
  
  def setup_translation
    @translation = Translation.find(params[:translation_id])
  end
  
  
  def index
    @authorities = Authority.all
  end

  def show
    @authority = Authority.find(params[:id])
  end

  def new
    @translation= = Translation.find(params[:translation_id])
    @authority = Authority.new
  end

  def create
    @authority = @translation.authorities.build(params[:authority])
    if @authority.save
      redirect_to @authority, :notice => "Successfully created authority."
    else
      render :action => 'new'
    end
  end

  def edit
    @authority = Authority.find(params[:id])
  end

  def update
    @authority = Authority.find(params[:id])
    if @authority.update_attributes(params[:authority])
      redirect_to @authority, :notice  => "Successfully updated authority."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @authority = Authority.find(params[:id])
    @authority.destroy
    redirect_to authorities_url, :notice => "Successfully destroyed authority."
  end
end

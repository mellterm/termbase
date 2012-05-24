class TranslationsController < ApplicationController
  def index
    @translations = Translation.all
  end

  def show
    @translation = Translation.find(params[:id])
    @contexts = @translation.contexts.all
  end

  def new
    @translation = Translation.new
    @domains = Domain.find(:all, :order => 'code ASC')
    @tar_languages = Language.find(:all, :order => 'iso_code DESC' )
    #will be user/group (after login branch)
    @translation.authority_id = 1
    #1 domain initially
    context = @translation.contexts.build
    
  end

  def create
    @translation = Translation.new(params[:translation])
    if @translation.save
      redirect_to @translation, :notice => "Successfully created translation."
    else
      render :action => 'new'
    end
  end

  def edit
    @translation = Translation.find(params[:id])
  end

  def update
    @translation = Translation.find(params[:id])
    if @translation.update_attributes(params[:translation])
      redirect_to @translation, :notice  => "Successfully updated translation."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @translation = Translation.find(params[:id])
    @translation.destroy
    redirect_to translations_url, :notice => "Successfully destroyed translation."
  end
  
  
  def copy
    original_translation = Translation.find(params[:id])
    @translation = original_translation.copy
    redirect_to edit_translation_path(@translation), :notice => "This is a copy of #{original_translation.source_content}"
  end
  
end

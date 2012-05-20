class TranslationsController < ApplicationController
  def index
    @translations = Translation.all
  end

  def show
    @translation = Translation.find(params[:id])
  end

  def new
    @translation = Translation.new
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
end

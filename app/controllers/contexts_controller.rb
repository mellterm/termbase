class ContextsController < ApplicationController
  def index
    @contexts = Context.all
  end

  def show
    @context = Context.find(params[:id])
  end

  def new
    ##a context needs a translation_id and a domain_id
    @translation = Translation.find(params[:translation_id])
    @domain = Domain.find(params[:domain_id])
    @context = Context.new
  end

  def create
    @context = Context.new(params[:context])
    if @context.save
      redirect_to @context, :notice => "Successfully created context."
    else
      render :action => 'new'
    end
  end

  def edit
    @context = Context.find(params[:id])
  end

  def update
    @context = Context.find(params[:id])
    if @context.update_attributes(params[:context])
      redirect_to @context, :notice  => "Successfully updated context."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @context = Context.find(params[:id])
    @context.destroy
    redirect_to contexts_url, :notice => "Successfully destroyed context."
  end
end

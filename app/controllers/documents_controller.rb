class DocumentsController < ApplicationController
  
  def index
     @documents = Document.all
   end
  
   def show
     @document = Document.find(params[:id])
     
     @docterms = @document.translations.where({:ilk => 'Term'})
     @docsegs = @document.translations.where({:ilk => 'Segment'}).paginate(:page => params[:page], :per_page => 30)
     @sourcelang = Language.find_by_id(@docsegs.first.source_language_id)
     @targetlang = Language.find_by_id(@docsegs.first.target_language_id)
   end
   
   def edit
      @document = Document.find(params[:id])
   end

   def new
     @document = Document.new
     @domains = Domain.find(:all, :order => 'code ASC')
      #1 domain initially
      domain = @document.domains.build
   end
  
  
  def create
    @document = Document.create( params[:document] )
    if @document.save
      redirect_to @document, :notice => "Successfully created document."
    else
      render :action => 'new'
    end
    
    
    
  end
  
  
end

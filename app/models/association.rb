class Association < ActiveRecord::Base
  attr_accessible :associate_id, :translation_id
  belongs_to :translation
  belongs_to :associate, :class_name => "Translation"
  
  #auto create reciprocal association between translations
  after_create :reciprocrate_association
  after_destroy :kill_association
  
  def reciprocrate_association
    associate.associates << translation unless associate.associates.include?(translation)
  end
  
  def kill_association
    associate.associates.delete(translation)
  end
  
  
end

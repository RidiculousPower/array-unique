# -*- encoding : utf-8 -*-

module ::Array::Unique::ByEquality

  ###########################
  #  add_to_unique_objects  #
  ###########################
  
  def add_to_unique_objects( object )
    
    @unique_keys[ object ] = true
    
  end

  ######################
  #  already_include?  #
  ######################
  
  def already_include?( object )
    
    return @unique_keys.has_key?( object )
    
  end

  ################################
  #  delete_from_unique_objects  #
  ################################

  def delete_from_unique_objects( object )
    
    @unique_keys.delete( object )
    
  end
  
end

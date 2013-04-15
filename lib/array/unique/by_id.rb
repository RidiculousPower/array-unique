# -*- encoding : utf-8 -*-

module ::Array::Unique::ByID

  ###########################
  #  add_to_unique_objects  #
  ###########################
  
  def add_to_unique_objects( object )
    
    @unique_keys[ object.__id__ ] = true
    
  end

  ######################
  #  already_include?  #
  ######################
  
  def already_include?( object )
    
    return @unique_keys.has_key?( object.__id__ )
    
  end

  ################################
  #  delete_from_unique_objects  #
  ################################

  def delete_from_unique_objects( object )
    
    @unique_keys.delete( object.__id__ )
    
  end
  
end

# -*- encoding : utf-8 -*-

module ::Array::Unique::ByIDAndEquality

  ###############################
  #  initialize_unique_objects  #
  ###############################

  def initialize_unique_objects

    super
    @unique_ids = { }

  end

  ###########################
  #  add_to_unique_objects  #
  ###########################
  
  def add_to_unique_objects( object )
    
    @unique_keys[ object ] = true
    @unique_ids[ object.__id__ ] = true
    
  end

  ######################
  #  already_include?  #
  ######################
  
  def already_include?( object )
    
    return @unique_keys.has_key?( object ) || @unique_ids.has_key?( object.__id__ )
    
  end

  ################################
  #  delete_from_unique_objects  #
  ################################

  def delete_from_unique_objects( object )
    
    @unique_keys.delete( object )
    @unique_ids.delete( object.__id__ )
    
  end
  
end

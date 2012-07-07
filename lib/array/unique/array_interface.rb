
module ::Array::Unique::ArrayInterface

  include ::Array::Hooked::ArrayInterface

  instances_identify_as!( ::Array::Unique )

  ################
  #  initialize  #
  ################
  
  def initialize( configuration_instance = nil, *args )

    @unique_keys = { }
    
    super
    
  end

  #####################################  Self Management  ##########################################

  #########
  #  []=  #
  #########

  def []=( index, object )

    # we only set if we don't already have the object being inserted
    # for this reason we return nil if no insert occurred

    return_value = nil

    # make sure that set is unique
    unless @unique_keys.has_key?( object )
      
      if index > count
        index = count
        unless object.nil? or @unique_keys.has_key?( nil )
          index += 1
        end
      end
      return_value = super

      @unique_keys[ object ] = true

    end
    
    return return_value
    
  end
  
  ################################################
  #  perform_single_object_insert_between_hooks  #
  ################################################
  
  def perform_single_object_insert_between_hooks( index, object )

    if @unique_keys.has_key?( object )
      index = nil
    else
      @unique_keys[ object ] = true
      index = super
    end
    
    return index
    
  end
  
  #####################################
  #  perform_delete_at_between_hooks  #
  #####################################
  
  def perform_delete_at_between_hooks( index )

    @unique_keys.delete( self[ index ] )

    return super
    
  end
  
  ##############
  #  include?  #
  ##############
  
  def include?( object )
    
    return @unique_keys.has_key?( object )
    
  end
  
  ##############
  #  collect!  #
  #  map!      #
  ##############

  def collect!
    
    return to_enum unless block_given?
    
    delete_indexes = [ ]
    self.each_with_index do |this_object, index|
      replacement_object = yield( this_object )
      if @unique_keys.has_key?( replacement_object ) and replacement_object != this_object
        delete_indexes.push( index )
      else
        self[ index ] = replacement_object
      end
    end
    
    delete_indexes.sort.reverse.each do |this_index|
      delete_at( this_index )
    end
    
    return self
    
  end
  alias_method :map!, :collect!

  ##########
  #  uniq  #
  ##########

  def uniq
  
    return self
  
  end

  ###########
  #  uniq!  #
  ###########

  def uniq!
  
    return self
  
  end
  
end

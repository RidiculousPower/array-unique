
module ::Array::Unique::Interface

  instances_identify_as!( ::Array::Unique )

  ################
  #  initialize  #
  ################
  
  def initialize( *args )

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

      @unique_keys[ object ] = true

      return_value = super

    end
    
    return return_value
    
  end
  
  ############
  #  insert  #
  ############
  
  def insert( index, *objects )

    # we only insert if we don't already have the object being inserted
    # for this reason we return nil if no insert occurred

    # if we have less elements in self than the index we are inserting at
    # we need to make sure the nils inserted cascade
    if index > count
      if @unique_keys.has_key?( nil )
        index -= ( index - count + 1 )
      else
        objects.unshift( nil )
        index -= ( index - count )
      end
    end
    
    # get rid of objects already inserted
    indexes_to_delete = [ ]
    objects.each_with_index do |this_object, index|
      if @unique_keys.has_key?( this_object )
        indexes_to_delete.push( index )
      else
        @unique_keys[ this_object ] = true
      end
    end
    indexes_to_delete.sort.reverse.each do |this_index|
      objects.delete_at( this_index )
    end

    return nil if objects.empty?

    return super
    
  end

  ##################################
  #  perform_delete_between_hooks  #
  ##################################
  
  def perform_delete_between_hooks( index )
    
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

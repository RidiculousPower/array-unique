# -*- encoding : utf-8 -*-

module ::Array::Unique::ArrayInterface

  include ::Array::Hooked::ArrayInterface
  include ::Array::Unique::ByEquality

  instances_identify_as!( ::Array::Unique )
    
  ################
  #  initialize  #
  ################
  
  def initialize( configuration_instance = nil, *args )

    initialize_unique_objects
    
    super
    
  end

  ###############################
  #  initialize_unique_objects  #
  ###############################

  def initialize_unique_objects

    @unique_keys = { }

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
    unless already_include?( object )
      
      # insert exactly one nil, or none if nil is already present
      top_bound = size
      if index > top_bound
        index = top_bound
        unless already_include?( nil )
          add_to_unique_objects( nil )
          undecorated_insert( top_bound, nil )
          index += 1
        end
      end
      return_value = super

      add_to_unique_objects( object )

    end
    
    return return_value
    
  end
  
  ###########################
  #  filter_insert_objects  #
  ###########################
  
  def filter_insert_objects( index, objects )

    objects.delete_if do |this_object| 
      add_to_unique_objects( this_object ) unless should_delete = already_include?( this_object )
      should_delete
    end

    return objects.empty? ? nil : super

  end
  
  #####################################
  #  perform_delete_at_between_hooks  #
  #####################################
  
  def perform_delete_at_between_hooks( index )

    delete_from_unique_objects( self[ index ] )

    return super
    
  end
  
  ##############
  #  include?  #
  ##############
  
  def include?( object )

    return already_include?( object )
    
  end
  
  ##############
  #  collect!  #
  #  map!      #
  ##############

  def collect!
    
    return to_enum unless block_given?
    
    delete_indexes = [ ]
    each_with_index do |this_object, index|
      replacement_object = yield( this_object )
      if already_include?( replacement_object ) and replacement_object != this_object
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

  alias_method :uniq, :dup

  ###########
  #  uniq!  #
  ###########

  def uniq!
  
    return self
  
  end
  
end

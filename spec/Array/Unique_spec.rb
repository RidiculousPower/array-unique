
require_relative '../../lib/unique-array.rb'

describe ::Array::Unique do

  ################
  #  initialize  #
  ################

  it 'can add initialize with an ancestor, inheriting its values and linking to it as a child' do
  
    unique_array = ::Array::Unique.new

    unique_array.instance_variable_get( :@parent_composite_object ).should == nil
    unique_array.should == []
    unique_array.push( :A, :B, :C, :D )
    
  end

  #########
  #  []=  #
  #########

  it 'can add elements' do
  
    unique_array = ::Array::Unique.new

    unique_array[ 0 ] = :A
    unique_array.should == [ :A ]

    unique_array[ 1 ] = :B
    unique_array.should == [ :A, :B ]

    unique_array[ 2 ] = :D
    unique_array.should == [ :A, :B, :D ]

  end
  
  ############
  #  insert  #
  ############

  it 'can insert elements' do
  
    unique_array = ::Array::Unique.new

    unique_array.insert( 3, :D )
    unique_array.should == [ nil, :D ]

    unique_array.insert( 1, :B )
    unique_array.should == [ nil, :B, :D ]

    unique_array.insert( 2, :C )
    unique_array.should == [ nil, :B, :C, :D ]

  end
  
  ##########
  #  push  #
  #  <<    #
  ##########
  
  it 'can add elements' do

    unique_array = ::Array::Unique.new

    unique_array << :A
    unique_array.should == [ :A ]

    unique_array << :B
    unique_array.should == [ :A, :B ]

  end
  
  ############
  #  concat  #
  #  +       #
  ############

  it 'can add elements' do

    # NOTE: this breaks + by causing it to modify the array like +=
    # The alternative was worse.

    unique_array = ::Array::Unique.new

    unique_array.concat( [ :A ] )
    unique_array.should == [ :A ]

    unique_array += [ :B ]
    unique_array.should == [ :A, :B ]

  end

  ####################
  #  delete_objects  #
  ####################

  it 'can delete multiple elements' do

    unique_array = ::Array::Unique.new

    unique_array += [ :A, :B ]
    unique_array.should == [ :A, :B ]

    unique_array.delete_objects( :A, :B )
    unique_array.should == [ ]

  end

  #######
  #  -  #
  #######
  
  it 'can exclude elements' do

    unique_array = ::Array::Unique.new

    unique_array.push( :A )
    unique_array.should == [ :A ]

    unique_array -= [ :A ]
    unique_array.should == [ ]

    unique_array.push( :B )
    unique_array.should == [ :B ]

  end

  ############
  #  delete  #
  ############
  
  it 'can delete elements' do

    unique_array = ::Array::Unique.new

    unique_array.push( :A )
    unique_array.should == [ :A ]

    unique_array.delete( :A )
    unique_array.should == [ ]

    unique_array.push( :B )
    unique_array.should == [ :B ]

  end

  ###############
  #  delete_at  #
  ###############

  it 'can delete by indexes' do

    unique_array = ::Array::Unique.new

    unique_array.push( :A )
    unique_array.should == [ :A ]
    
    unique_array.delete_at( 0 )
    unique_array.should == [ ]

    unique_array.push( :B )
    unique_array.should == [ :B ]

  end

  #######################
  #  delete_at_indexes  #
  #######################

  it 'can delete by indexes' do

    unique_array = ::Array::Unique.new

    unique_array.push( :A, :B, :C )
    unique_array.should == [ :A, :B, :C ]

    unique_array.delete_at_indexes( 0, 1 )
    unique_array.should == [ :C ]

  end

  ###############
  #  delete_if  #
  ###############

  it 'can delete by block' do

    unique_array = ::Array::Unique.new

    unique_array.push( :A, :B, :C )
    unique_array.should == [ :A, :B, :C ]
    unique_array.delete_if do |object|
      object != :C
    end
    unique_array.should == [ :C ]

    unique_array.delete_if.is_a?( Enumerator ).should == true

  end

  #############
  #  keep_if  #
  #############

  it 'can keep by block' do

    unique_array = ::Array::Unique.new

    unique_array.push( :A, :B, :C )
    unique_array.should == [ :A, :B, :C ]
    unique_array.keep_if do |object|
      object == :C
    end
    unique_array.should == [ :C ]

  end

  ##############
  #  compact!  #
  ##############

  it 'can compact' do

    unique_array = ::Array::Unique.new

    unique_array.push( :A, nil, :B, nil, :C, nil )
    unique_array.should == [ :A, nil, :B, :C ]
    unique_array.compact!
    unique_array.should == [ :A, :B, :C ]

  end

  ##############
  #  flatten!  #
  ##############

  it 'can flatten' do

    unique_array = ::Array::Unique.new

    unique_array.push( :A, [ :F_A, :F_B ], :B, [ :F_C ], :C, [ :F_D ], [ :F_E ] )
    unique_array.should == [ :A, [ :F_A, :F_B ], :B, [ :F_C ], :C, [ :F_D ], [ :F_E ] ]
    unique_array.flatten!
    unique_array.should == [ :A, :F_A, :F_B, :B, :F_C, :C, :F_D, :F_E ]

  end

  #############
  #  reject!  #
  #############

  it 'can reject' do

    unique_array = ::Array::Unique.new

    unique_array.push( :A, :B, :C )
    unique_array.should == [ :A, :B, :C ]
    unique_array.reject! do |object|
      object != :C
    end
    unique_array.should == [ :C ]

    unique_array.reject!.is_a?( Enumerator ).should == true

  end

  #############
  #  replace  #
  #############

  it 'can replace self' do

    unique_array = ::Array::Unique.new

    unique_array.push( :A, :B, :C )
    unique_array.should == [ :A, :B, :C ]
    unique_array.replace( [ :D, :E, :F ] )
    unique_array.should == [ :D, :E, :F ]

  end

  ##############
  #  reverse!  #
  ##############

  it 'can reverse self' do

    unique_array = ::Array::Unique.new

    unique_array.push( :A, :B, :C )
    unique_array.should == [ :A, :B, :C ]
    unique_array.reverse!
    unique_array.should == [ :C, :B, :A ]

  end

  #############
  #  rotate!  #
  #############

  it 'can rotate self' do

    unique_array = ::Array::Unique.new

    unique_array.push( :A, :B, :C )
    unique_array.should == [ :A, :B, :C ]

    unique_array.rotate!
    unique_array.should == [ :B, :C, :A ]

    unique_array.rotate!( -1 )
    unique_array.should == [ :A, :B, :C ]

  end

  #############
  #  select!  #
  #############

  it 'can keep by select' do

    unique_array = ::Array::Unique.new

    unique_array.push( :A, :B, :C )
    unique_array.should == [ :A, :B, :C ]
    unique_array.select! do |object|
      object == :C
    end
    unique_array.should == [ :C ]

    unique_array.select!.is_a?( Enumerator ).should == true

  end

  ##############
  #  shuffle!  #
  ##############

  it 'can shuffle self' do

    unique_array = ::Array::Unique.new

    unique_array.push( :A, :B, :C )
    unique_array.should == [ :A, :B, :C ]

    prior_version = unique_array.dup
    attempts = [ ]
    50.times do
      unique_array.shuffle!
      attempts.push( unique_array == prior_version )
      prior_version = unique_array.dup
    end
    attempts_correct = attempts.select { |member| member == false }.count
    ( attempts_correct >= 10 ).should == true
    first_shuffle_version = unique_array

  end

  ##############
  #  collect!  #
  #  map!      #
  ##############

  it 'can replace by collect/map' do

    unique_array = ::Array::Unique.new

    unique_array.push( :A, :B, :C )
    unique_array.should == [ :A, :B, :C ]
    unique_array.collect! do |object|
      :C
    end
    unique_array.should == [ :C ]

    unique_array.collect!.is_a?( Enumerator ).should == true

  end

  ###########
  #  sort!  #
  ###########

  it 'can replace by collect/map' do

    unique_array = ::Array::Unique.new

    unique_array.push( :A, :B, :C )
    unique_array.should == [ :A, :B, :C ]
    unique_array.sort! do |a, b|
      if a < b
        1
      elsif a > b
        -1
      elsif a == b
        0
      end
    end
    unique_array.should == [ :C, :B, :A ]

    unique_array.sort!
    unique_array.should == [ :A, :B, :C ]

  end

  ##############
  #  sort_by!  #
  ##############

  it 'can replace by collect/map' do

    unique_array = ::Array::Unique.new

    unique_array.push( :A, :B, :C )
    unique_array.should == [ :A, :B, :C ]
    unique_array.sort_by! do |object|
      case object
      when :A
        :B
      when :B
        :A
      when :C
        :C
      end
    end
    unique_array.should == [ :B, :A, :C ]

    unique_array.sort_by!.is_a?( Enumerator ).should == true

  end

  ###########
  #  uniq!  #
  ###########

  it 'can remove non-unique elements' do

    unique_array = ::Array::Unique.new

    unique_array.push( :A, :B, :C, :C, :C, :B, :A )
    unique_array.should == [ :A, :B, :C ]
    unique_array.uniq!
    unique_array.should == [ :A, :B, :C ]

  end

  #############
  #  unshift  #
  #############

  it 'can unshift onto the first element' do

    unique_array = ::Array::Unique.new

    unique_array += :A
    unique_array.should == [ :A ]

    unique_array.unshift( :B )
    unique_array.should == [ :B, :A ]

  end

  #########
  #  pop  #
  #########
  
  it 'can pop the final element' do

    unique_array = ::Array::Unique.new

    unique_array += :A
    unique_array.should == [ :A ]

    unique_array.pop.should == :A
    unique_array.should == [ ]

    unique_array += :B
    unique_array.should == [ :B ]

  end

  ###########
  #  shift  #
  ###########
  
  it 'can shift the first element' do

    unique_array = ::Array::Unique.new

    unique_array += :A
    unique_array.should == [ :A ]

    unique_array.shift.should == :A
    unique_array.should == [ ]

    unique_array += :B
    unique_array.should == [ :B ]

  end

  ############
  #  slice!  #
  ############
  
  it 'can slice elements' do

    unique_array = ::Array::Unique.new

    unique_array += :A
    unique_array.should == [ :A ]

    unique_array.slice!( 0, 1 ).should == [ :A ]
    unique_array.should == [ ]

    unique_array += :B
    unique_array.should == [ :B ]

  end
  
  ###########
  #  clear  #
  ###########

  it 'can clear, causing present elements to be excluded' do

    unique_array = ::Array::Unique.new

    unique_array += :A
    unique_array.should == [ :A ]

    unique_array.clear
    unique_array.should == [ ]

    unique_array += :B
    unique_array.should == [ :B ]

  end

  ##################
  #  pre_set_hook  #
  ##################

  it 'has a hook that is called before setting a value; return value is used in place of object' do
    
    class ::Array::Unique::SubMockPreSet < ::Array::Hooked
      
      def pre_set_hook( index, object, is_insert = false )
        return :some_other_value
      end
      
    end
    
    unique_array = ::Array::Unique::SubMockPreSet.new

    unique_array.push( :some_value )
    
    unique_array.should == [ :some_other_value ]
    
  end

  ###################
  #  post_set_hook  #
  ###################

  it 'has a hook that is called after setting a value' do

    class ::Array::Unique::SubMockPostSet < ::Array::Hooked
      
      def post_set_hook( index, object, is_insert = false )
        return :some_other_value
      end
      
    end
    
    unique_array = ::Array::Unique::SubMockPostSet.new

    unique_array.push( :some_value ).should == [ :some_other_value ]
    
    unique_array.should == [ :some_value ]
    
  end

  ##################
  #  pre_get_hook  #
  ##################

  it 'has a hook that is called before getting a value; if return value is false, get does not occur' do
    
    class ::Array::Unique::SubMockPreGet < ::Array::Hooked
      
      def pre_get_hook( index )
        return false
      end
      
    end
    
    unique_array = ::Array::Unique::SubMockPreGet.new
    
    unique_array.push( :some_value )
    unique_array[ 0 ].should == nil
    
    unique_array.should == [ :some_value ]
    
  end

  ###################
  #  post_get_hook  #
  ###################

  it 'has a hook that is called after getting a value' do

    class ::Array::Unique::SubMockPostGet < ::Array::Hooked
      
      def post_get_hook( index, object )
        return :some_other_value
      end
      
    end
    
    unique_array = ::Array::Unique::SubMockPostGet.new
    
    unique_array.push( :some_value )
    unique_array[ 0 ].should == :some_other_value
    
    unique_array.should == [ :some_value ]
    
  end

  #####################
  #  pre_delete_hook  #
  #####################

  it 'has a hook that is called before deleting an index; if return value is false, delete does not occur' do
    
    class ::Array::Unique::SubMockPreDelete < ::Array::Hooked
      
      def pre_delete_hook( index )
        return false
      end
      
    end
    
    unique_array = ::Array::Unique::SubMockPreDelete.new
    
    unique_array.push( :some_value )
    unique_array.delete_at( 0 )
    
    unique_array.should == [ :some_value ]
    
  end

  ######################
  #  post_delete_hook  #
  ######################

  it 'has a hook that is called after deleting an index' do
    
    class ::Array::Unique::SubMockPostDelete < ::Array::Hooked
      
      def post_delete_hook( index, object )
        return :some_other_value
      end
      
    end
    
    unique_array = ::Array::Unique::SubMockPostDelete.new
    
    unique_array.push( :some_value )
    unique_array.delete_at( 0 ).should == :some_other_value
    
    unique_array.should == [ ]
    
  end
  
end

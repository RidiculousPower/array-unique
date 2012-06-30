
require 'array/hooked'

# namespaces that have to be declared ahead of time for proper load order
require_relative './namespaces'

# source file requires
require_relative './requires.rb'

class ::Array::Unique < ::Array::Hooked
  
  include ::Array::Unique::Interface
    
end

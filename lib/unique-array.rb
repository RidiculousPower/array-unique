
#require 'hooked-array'
require_relative '../../hooked-array/lib/hooked-array.rb'

class ::Array::Unique < ::Array::Hooked
end
class ::UniqueArray < ::Array::Unique
end

basepath = 'unique-array/Array/Unique'

files = [
  
  'Interface'
  
]

second_basepath = 'unique-array/UniqueArray'

second_files = [
  
]

files.each do |this_file|
  require_relative( File.join( basepath, this_file ) + '.rb' )
end
second_files.each do |this_file|
  require_relative( File.join( second_basepath, this_file ) + '.rb' )
end

require_relative( basepath + '.rb' )
require_relative( second_basepath + '.rb' )

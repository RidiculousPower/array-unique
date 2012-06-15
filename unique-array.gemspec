require 'date'

Gem::Specification.new do |spec|

  spec.name                      =  'unique-array'
  spec.rubyforge_project         =  'unique-array'
  spec.version                   =  '1.0.2'

  spec.summary                   =  "Provides Array::Unique and UniqueArray."
  spec.description               =  "A subclass of Array::Hooked that also keeps array unique."

  spec.authors                   =  [ 'Asher' ]
  spec.email                     =  'asher@ridiculouspower.com'
  spec.homepage                  =  'http://rubygems.org/gems/unique-array'

  spec.add_dependency            'hooked-array'

  spec.date                      = Date.today.to_s
  
  spec.files                     = Dir[ '{lib,spec}/**/*',
                                        'README*', 
                                        'LICENSE*',
                                        'CHANGELOG*' ]

end

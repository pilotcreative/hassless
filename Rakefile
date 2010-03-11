# encoding: UTF-8
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "hassless"
    gem.summary = "Make LESS less of a hassle."
    gem.description = "Makes LESS less of a hassle on read-only filesystems by compiling and serving it up for you."
    gem.email = "gems@objectreload.com"
    gem.homepage = "http://github.com/objectreload/hassless"
    gem.authors = ["Mateusz Drożdżyński"]
    gem.files = FileList["LICENSE", "README.textile", "lib/hassless.rb", "lib/hassless/compiler.rb", "lib/hassless/middleware.rb", "rails/init.rb"]
    gem.add_dependency('rack')
    gem.add_dependency('less')
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

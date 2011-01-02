require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "evernicious"
  gem.homepage = "http://github.com/jorgemanrubia/evernicious"
  gem.license = "MIT"
  gem.summary = %Q{A tool for converting delicious bookmarks (HTML file) to Evernote format (ENEX file)}
  gem.description = %Q{A tool for converting delicious bookmarks (HTML file) to Evernote format (ENEX file). The delicious HTML file can be exported from del.icio.us. The generated ENEX file can be imported into Evernote using the official desktop Evernote client.}
  gem.email = "jorge.manrubia@gmail.com"
  gem.authors = ["Jorge Manrubia"]
  

  
  gem.executables = ['evernicious']
end
Jeweler::RubygemsDotOrgTasks.new

require 'spec/rake/spectask'

Spec::Rake::SpecTask.new do |task|
  task.spec_opts = ["--color"]
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "evernicious #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

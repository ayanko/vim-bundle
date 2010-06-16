require 'rake/gempackagetask'

spec = Gem::Specification.new do |s|
  s.name        = "vim-bundle"
  s.version     = `git tag -l v*`.sort.last.delete("v")
  s.summary     = "VIM bundle managment (with pathogen)"
  s.homepage    = "http://ayanko@github.com/ayanko/vim-bundle.git"
  s.email       = "andriy.yanko@gmail.com"
  s.authors     = ["Andriy Yanko"]
  s.files       = `git ls-files`.split("\n")
  s.executables = %w(vim-bundle)
  s.has_rdoc    = true
end

Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
end


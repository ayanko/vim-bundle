module VimBundle
  module Commands
    extend self
  end
end

Dir[File.join(File.dirname(__FILE__), "commands", "*.rb")].each do |file|
  require file

  VimBundle.commands.push File.basename(file, ".rb")
end

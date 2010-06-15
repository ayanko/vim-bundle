module VimBundle
  module Commands
    def help
      puts <<-HELP
USAGE: #{$0} [command]
    init:   install pathogen plugin
    sample: show sample config file
HELP
    end
  end
end


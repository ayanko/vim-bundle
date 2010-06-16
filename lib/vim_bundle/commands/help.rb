module VimBundle
  module Commands
    def help
      puts <<-HELP
REQUIRED SYSTEM TOOLS:
    git, curl, unzip, tar, gz
USAGE: #{$0} [command]
    init:   install bundle plugin (pathogen)
    sample: show sample config file
    update: update all bundles
HELP
    end
  end
end


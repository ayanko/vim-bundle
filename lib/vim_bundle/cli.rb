module VimBundle
  module CLI

    class << self
      def execute
        command = VimBundle.commands.include?(ARGV[0]) ? ARGV[0] : 'help'
        VimBundle::Commands.send(command)
      end
    end
    
  end
end

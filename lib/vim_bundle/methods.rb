require "yaml"

module VimBundle
  module Methods
    def vim_home
      File.join(ENV['HOME'], '.vim')
    end

    def dir
      File.join(self.vim_home, 'bundle')
    end

    def default_config_file
      File.join(self.vim_home, 'bundle.yml')
    end
    
    def config
      @config ||= YAML.load_file(default_config_file)
    end

    def commands
      @commands ||= []
    end
  end

  extend Methods
end

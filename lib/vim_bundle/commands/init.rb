require 'net/http'
require 'fileutils'

module VimBundle
  module Commands

    def init
      pathogen_file = File.join(VimBundle.vim_home, 'autoload', 'pathogen.vim')

      puts "Installing #{pathogen_file} ..."

      FileUtils.mkdir_p(File.dirname(pathogen_file))

      File.open(pathogen_file, "w") { |f| f.write Net::HTTP.get(URI.parse(pathogen_url)) }

      puts <<-DATA
DONE. Please add to your .vimrc next lines:

  call pathogen#helptags()
  call pathogen#runtime_append_all_bundles()

DATA
    end
    
    def pathogen_url
      "http://github.com/tpope/vim-pathogen/raw/master/autoload/pathogen.vim"
    end
  end
end

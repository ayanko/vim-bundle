module VimBundle
  module Commands
    def sample
      puts File.read(File.join(File.dirname(__FILE__), '..', '..', '..', 'config', 'sample.yml'))
    end
  end
end

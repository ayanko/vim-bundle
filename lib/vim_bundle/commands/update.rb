require 'net/http'
require 'fileutils'

module VimBundle
  module Commands
    def update
      bundles = VimBundle.config['bundles']

      abort("No bundles defined") if blank_value?(bundles)
        
      self.erase_bundles
      self.bundles.each { |bundle| install_bundle(bundle) }
    end

    protected

    def erase_bundles
      FileUtils.rm_rf(VimBundle.dir)
      File.mkdir(VimBundle.dir)
    end

    def install_bundle(bundle)
      %w(dir url).each do |key|
        abort("bundle #{key} is not specified") if self.blank_value?(bundle[key])
      end

      puts "Updating bundle #{bundle['dir']} ..."

      case bundle['type']
      when 'git':

      when 'tgz':
        dir = File.join(VimBundle.dir, bundle['dir'])

        FileUtils.mkdir_p(dir)
        system("curl -s #{bundle['url']} | tar xz -C #{dir}") || abort("Failed")

      when 'vim':
        abort("bundle subdir is not specified") if self.blank_value?(bundle['subdir'])
        
        filepath = File.join(VimBundle.dir, bundle['dir'], bundle['subdir'], bundle['dir'] + ".vim")

        FileUtils.mkdir_p(File.dirname(filepath))
        File.open(filepath, 'w') { |f| f << Net::HTTP.get(URI.parse(bundle['url'])) }

      else
        abort("Unsupported #{bundle['type'].inspect} file type")
      end
    end

    def blank_value?(value)
      value.nil? || value.empty?
    end
  end
end


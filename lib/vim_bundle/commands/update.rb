require 'net/http'
require 'fileutils'

module VimBundle
  module Commands
    def update
      bundles = VimBundle.config['bundles']

      abort("No bundles defined") if blank_value?(bundles)
        
      self.erase_bundles(bundles)
      bundles.each { |bundle| install_bundle(bundle) }
    end

    protected

    def erase_bundles(bundles)
      puts "Erasing all (#{bundles.size}) bundles in #{VimBundle.dir} ..."

      FileUtils.rm_rf(VimBundle.dir)
      FileUtils.mkdir_p(VimBundle.dir)
    end

    def install_bundle(bundle)
      validate_bundle(bundle)

      puts "Updating bundle #{bundle['dir']} ..."

      method = "install_#{bundle['type']}_bundle"
    
      self.respond_to?(method) ?
        self.send(method, bundle) : 
        abort("Unsupported #{bundle['type'].inspect} file type")
    end

    def install_git_bundle(bundle)
      dir = self.create_bundle_dir(bundle)
      system("git clone -q #{bundle['url']} #{dir}") || abort("Failed")
      FileUtils.rm_rf(File.join(dir, '.git'))
    end

    def install_tgz_bundle(bundle)
      dir = self.create_bundle_dir(bundle)
      system("curl -s #{bundle['url']} | tar xz -C #{dir}") || abort("Failed")
    end
    
    def install_zip_bundle(bundle)
      dir = self.create_bundle_dir(bundle)
      archive_path = File.join(dir, 'bundle.zip')
      system("curl -s #{bundle['url']} -o #{archive_path}") || abort("Failed")
      system("unzip -q -d #{dir} #{archive_path}") || abort("Failed")
      FileUtils.rm_rf(archive_path)
    end

    def install_vim_bundle(bundle)
      abort("bundle subdir is not specified") if self.blank_value?(bundle['subdir'])

      filepath = File.join(VimBundle.dir, bundle['dir'], bundle['subdir'], bundle['dir'] + ".vim")

      FileUtils.mkdir_p(File.dirname(filepath))
      File.open(filepath, 'w') { |f| f << Net::HTTP.get(URI.parse(bundle['url'])) }
    end

    def validate_bundle(bundle)
      %w(dir url type).each do |key|
        abort("bundle #{key} is not specified") if self.blank_value?(bundle[key])
      end
    end

    def blank_value?(value)
      value.nil? || value.empty?
    end

    def create_bundle_dir(bundle)
      dir = File.join(VimBundle.dir, bundle['dir'])
      FileUtils.mkdir_p(dir)
      dir
    end
  end
end


module VimBundle
  module Commands
    def sample_config
      {
        'bundles' => [
          {
            'dir'  => 'IndentAnything',
            'url'  => 'http://www.vim.org/scripts/script.php?script_id=10228',
            'type' => 'tgz'
          },
          {
            'dir'    => 'JavascriptIndent',
            'url'    => 'http://www.vim.org/scripts/script.php?script_id=11838',
            'type'   => 'vim',
            'subdir' => 'indent'
          },
          {
            'dir'    => 'BlockComment',
            'url'    => 'http://www.vim.org/scripts/script.php?script_id=1387',
            'type'   => 'vim',
            'subdir' => 'plugin'
          },
          {
            'dir'  => 'vim-cucumber',
            'url'  => 'git://github.com/tpope/vim-cucumber.git',
            'type' => 'git'
          }
        ]
      }
    end

    def sample
      puts self.sample_config.to_yaml
    end
  end
end

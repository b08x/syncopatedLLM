#!/usr/bin/env ruby
# frozen_string_literal: true

lib_dir = File.expand_path(File.join(__dir__, '..', 'lib'))
$LOAD_PATH.unshift lib_dir unless $LOAD_PATH.include?(lib_dir)

module Laudllm

  module Filter
    module_function
      
    # https://junegunn.kr/2016/02/using-fzf-in-your-program
    def with_filter(command)
      io = IO.popen(command, 'r+')
      begin
        stdout, $stdout = $stdout, io
        yield rescue nil
      ensure
        $stdout = stdout
      end
      io.close_write
      io.readlines.map(&:chomp)
    end

    # selected_files = `find #{library} -name "*.*" | fzf -m --cycle --border=rounded --preview="play {}"`

    def fuzzyplay(files)
      p files
      with_filter('fzf -m --cycle --layout=reverse-list --border=rounded --preview="cat {}"') 
        files.each do |n|
          puts n
        end
      end
    end

end



# library = Soundbot::Config.get(:library)
#
# library = library + "/Sounds"
#
# files = Glob.files(library)
#
# Soundbot::Filter.fuzzyplay(files)

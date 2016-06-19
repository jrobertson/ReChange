require 'rack-rscript'

path = File.expand_path('~/bluebank')
run RackRscript.new({pkg_src: path})


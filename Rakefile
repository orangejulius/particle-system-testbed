FILES = FileList["*.lua", "*.conf", "readme.txt", "**/*.jpg"]

task :zip => FILES do
  sh "zip $TMP/particle-system-testbed.love #{FILES.join(' ')}"
end

task :run => :zip do
  sh "open $TMP/particle-system-testbed.love"
end

task :default => :run

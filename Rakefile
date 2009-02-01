FILES = FileList["*.lua", "*.conf", "README", "**/*.jpg", "**/*.png", "**/*.wav"]

task :zip => FILES do
  sh "zip $TMP/baby-pow.love #{FILES.join(' ')}"
end

task :run => :zip do
  sh "open $TMP/baby-pow.love"
end

task :default => :run

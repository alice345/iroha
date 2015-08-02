require_relative 'chunk'

file = File.open(ARGV[0], mode = 'rb')
chunk = FormAiffChunk.new(file)
common = CommonChunk.new(chunk)
sound_data = SoundDataChunk.new(chunk)

puts chunk.to_s, common.to_s, sound_data.to_s
file.close

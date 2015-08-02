require 'csv'
require 'pry'
require_relative 'chunk'

file = File.open(ARGV[0], mode = 'rb')
csv = CSV.open('time_domain_wave.csv', mode = 'w')

chunk = FormAiffChunk.new(file)
common = CommonChunk.new(chunk)
sound_chunk = SoundDataChunk.new(chunk)
puts chunk.to_s, common.to_s, sound_chunk.to_s

common.num_sample_frames.times do |frame|
  sound = sound_chunk.data.slice(frame*4-4,2).unpack("s*")[0].to_f
  csv << [frame.to_f/common.sample_rate, sound]
end

file.close
csv.close

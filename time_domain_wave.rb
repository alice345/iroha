require 'csv'
require 'pry'
require_relative 'chunk'

file = File.open(ARGV[0], mode = 'rb')
csv = CSV.open('time_domain_wave.csv', mode = 'w')
chunk = FormAiffChunk.new(file)
common = CommonChunk.new(chunk)
sound_chunk = SoundDataChunk.new(chunk)

output = Array.new
puts chunk.to_s, common.to_s, sound_chunk.to_s

common.num_sample_frames.times do |frame|
  csv << [frame.to_f/common.sample_rate, sound_chunk.data.slice!(0,4).slice(0,2).unpack('n')[0].to_i]
  puts "進捗#{frame/common.num_sample_frames*100}%"
end

file.close
csv.close

class FormAiffChunk
  attr_accessor(:id, :size, :form_type, :common, :sound)

  def initialize(file)
    @id= file.read(4)
    @size = file.read(4).unpack('N')[0].to_i
    @form_type = file.read(4)
    @common = file.read(26)
    @sound = file.read(@size - 26)
  end
end

class CommonChunk
  attr_accessor(:id, :common_size, :num_channels, :num_sample_frames, :sample_size, :sample_rate)

  def initialize(chunk)
    @id = chunk.common.slice(0,4)
    @common_size = chunk.common.slice(4,4).unpack('N')[0].to_i
    @num_channels = chunk.common.slice(8,2).unpack('n')[0].to_i
    @num_sample_frames = chunk.common.slice(10,4).unpack('N')[0].to_i
    @sample_size = chunk.common.slice(14,2).unpack('n')[0].to_i 
    @sample_rate = chunk.common.slice(18,8).unpack('n')[0].to_i
  end

  def to_s
    <<EOS
ChunkID:         #{@id}
Channels:        #{@num_channels}
NumSampleFrames: #{@num_sample_frames}
SampleSize:      #{@sample_size}
SampleRate:      #{@sample_rate}
EOS
  end
end

file = File.open(ARGV[0], mode = "rb")
chunk = HeaderChunk.new(file)
common = CommonChunk.new(chunk)
puts common.to_s
file.close

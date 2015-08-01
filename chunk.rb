class HeaderChunk
  attr_accessor(:name, :size, :data)

  def initialize(file)
    @name = file.read(4)
    @size = file.read(4).unpack('N')[0].to_i
    @form_type = file.read(4)
    @data = file.read(@size)
  end
end

class CommonChunk
  attr_accessor(:id, :common_size, :num_channels, :num_sample_frames, :sample_size, :sample_rate)

  def initialize(chunk)
    @id = chunk.data.slice(0,4)
    @common_size = chunk.data.slice(4,4).unpack('N')[0].to_i
    @num_channels = chunk.data.slice(8,2).unpack('n')[0].to_i
    @num_sample_frames = chunk.data.slice(10,4).unpack('N')[0].to_i
    @sample_size = chunk.data.slice(14,2).unpack('n')[0].to_i 
    @sample_rate = chunk.data.slice(18,8).unpack('n')[0].to_i
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

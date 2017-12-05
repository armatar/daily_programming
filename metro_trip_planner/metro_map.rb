require 'byebug'

class MetroMap
  def self.read_from_file
    raw_metro_map = []
    File.open("metro_map.txt", "r") do |f|
      f.each_line do |line|
        clean_string = line.tr("\n", '')
        clean_string = clean_string.tr(" ", '')
        raw_metro_map.push(clean_string.split(','))
      end
    end
    return raw_metro_map
  end

  def self.create_metro_map
    metro_map = []
    raw_metro_map = read_from_file
    raw_metro_map.each do |line|
      metro_map.push(update_metro_map(line))
    end
    return metro_map
  end

  def self.update_metro_map(line_array)
    line = {station1: line_array[0], color1: line_array[1], station2: line_array[2], 
            color2: line_array[3], time: line_array[4].to_i}
    return line
  end

  def self.metro_map
    @@metro_map = create_metro_map
  end
end
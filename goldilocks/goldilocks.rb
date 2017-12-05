require 'byebug'

class Goldilocks

  def goldi_calculator(input)
    goldi_weight = input[0][0]
    goldi_temp = input[0][1]

    input.shift
    line_number = 1
    list_of_valid_places = []
    input.each do | line |
      if line[0] >= goldi_weight && line[1] <= goldi_temp
        list_of_valid_places.push(line_number)
      end
      line_number += 1
    end

    return list_of_valid_places
  end

  def get_input_from_file(filename)
    input = []
    File.open(filename, "r") do |f|
      f.each_line do |line|
        line = line.tr("\n", '')
        line = line.split(' ')
        line[0] = line[0].to_i
        line[1] = line[1].to_i
        input.push(line)
      end
    end
    return input
  end

end

goldilocks = Goldilocks.new
input = goldilocks.get_input_from_file("challenge_input.txt")
puts goldilocks.goldi_calculator(input).inspect
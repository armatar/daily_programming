require 'byebug'

def jenny(market, goal)
    return []            if goal < 0
    return [Hash.new(0)] if goal == 0
    return []            if market.empty?

    f, p = market[0]
    take  = jenny(market, goal - p).map { |ans| ans[f] += 1; ans }
    leave = jenny(market[1..-1], goal)

    return (take + leave)
end

def get_input_from_file(filename)
  fruit_array = []
  File.open(filename, "r") do |f|
    f.each_line do |line|
      line = line.tr("\n", '')
      line = line.split(' ')
      fruit_array.push([line[0], line[1].to_i])
    end
  end
  return fruit_array
end

market = get_input_from_file("sample_input.txt")

puts jenny(market, 500).inspect

#jenny(market, 500).each do |ans|
#    puts ans.map { |fruit, n| "#{n} #{fruit}#{n == 1 ? '' : 's'}" }.join ", "
#end
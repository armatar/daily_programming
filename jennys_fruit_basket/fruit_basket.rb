class FruitBasket
  def calculate_fruit_to_buy(budget, fruit_hash)
    
  end

  def get_input_from_file(filename)
    fruit_hash = {}
    File.open(filename, "r") do |f|
      f.each_line do |line|
        line = line.tr("\n", '')
        line = line.split(' ')
        fruit_hash[line[0]] = line[1].to_i
      end
    end
    return fruit_hash
  end
end

fruit_basket = FruitBasket.new
fruit_basket.get_input_from_file("sample_input.txt")
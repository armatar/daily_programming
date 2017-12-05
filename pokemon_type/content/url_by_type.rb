module UrlByType

  def get_number_associated_with_type
    numbers_and_type = {
      "normal" => 1,
      "fighting" => 2,
      "flying" => 3,
      "poison" => 4,
      "ground" => 5,
      "rock" => 6,
      "bug" => 7,
      "ghost" => 8,
      "steel" => 9,
      "fire" => 10,
      "water" => 11,
      "grass" => 12,
      "electric" => 13,
      "psychic" => 14,
      "ice" => 15,
      "dragon" => 16,
      "dark" => 17,
      "fairy" => 18
    }

    return numbers_and_type
  end

  def get_url(type)
    numbers_and_type = get_number_associated_with_type
    number = numbers_and_type[type]
    url = "https://pokeapi.co/api/v2/type/#{number}/"
    return url
  end
end
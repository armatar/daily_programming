class Hacking
  def get_input(guesses)
    puts "Guess (#{guesses} left )"
    print "> "
    guess = gets.chomp
    return guess
  end

  def get_difficulty
    puts "What difficulty (1-5)?"
    print "> "
    difficulty = gets.chomp.to_i

    difficulty_list = {1 => [6, 6], 2 => [7, 8], 3 => [8, 11], 4 => [9, 13], 5=> [10, 15]}
    difficulty = difficulty_list[difficulty]
    return difficulty
  end

  def begin_game
    system "clear"
    difficulty = get_difficulty
    words = get_list_of_words(difficulty)
    puts "-" * 50
    print_words(words)
    puts "-" * 50
    secret = words.sample
    number_correct = nil
    guesses = (4)
    while true
      guess = get_input(guesses)
      if guess == secret
        puts "You were right! You've won the game!"
        break
      end
      number_correct = check_for_number_characters_right(guess, secret)
      puts "Number Correct: #{number_correct}/#{secret.length}"
      guesses -= 1
      if guesses == 0
        puts "You've run out of guesses and have lost the game. The word was #{secret}."
        break
      end
    end

  end

  private

    def check_for_number_characters_right(guessed_word, secret)
      word_hash = guessed_word.split("")
      secret_hash = secret.split("")
      number_correct = 0
      secret_hash.each_with_index do |character, index|
        if character == word_hash[index]
          number_correct += 1
        end
      end
      return number_correct
    end

    def print_words(words)
      words.each do |word|
        puts word
      end
    end

    def get_random_word(length)
      chosen_line = nil
      while !chosen_line
        line = File.readlines("enable1.txt").sample.tr("\r\n", "")
        chosen_line = line if length.include?(line.length)
      end
      return chosen_line
    end

    def get_list_of_words(difficulty)
      list_of_words = []
      number_of_words = difficulty.shift
      number_of_words.times do
        list_of_words.push(get_random_word(difficulty))
      end

      return list_of_words
    end

end

hacking = Hacking.new
puts hacking.begin_game

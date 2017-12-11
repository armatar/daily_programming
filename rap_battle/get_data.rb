require 'open-uri'
require 'byebug'

class GetData
  attr_reader :dictionary_hash

  def initialize
    create_vowels
    @dictionary = get_data_from_url("http://svn.code.sf.net/p/cmusphinx/code/trunk/cmudict/cmudict-0.7b")
    @dictionary = @dictionary.encode('UTF-8', :invalid => :replace)
    @dictionary = @dictionary.split("\n")
    @dictionary_hash = make_dictionary_into_hash(@dictionary)
  end

  def get_rhyming_words(word)
    word = word.upcase
    if !@dictionary_hash[word]
      return "#{word.upcase} is not a real word!"
    end
    matching_words = find_matching_words(word)
    if matching_words.length > 0
      print_matches(matching_words)
      return "Found #{matching_words.length} matching words."
    else
      return "There is nothing that rhymes with #{word}!"
    end
  end

  private

    def find_matching_words(word_to_match)
      final_sound = []
      matching_words = {}
      sound_to_match = get_final_sound(@dictionary_hash[word_to_match].reverse)
      puts "Sound to match: #{sound_to_match}"
      @dictionary_hash.each_pair do | word, sound |
        if sound
          final_sound = get_final_sound(sound.reverse)
          if final_sound == sound_to_match
            matching_words[word] = sound
          end
        end
      end
      return matching_words
    end

    def print_matches(matching_words)
      matching_words.each_pair do |word, sound|
        puts word
      end
    end

    def get_final_sound(sounds)
      final_sound = []
      sounds.each do | sound |
      final_sound.push(sound)
        if @stressed_vowels.include?(sound)
          break
        end
      end
      return final_sound
    end

      def create_vowels
          @stressed_vowels = ["AA1", "AE1", "AH1", "AO1", "AW1", "AY1", "EH1", "ER1", "EY1", "IH1", "IY1", "OW1", "OY1", "UH1", "UW1", "W1", "Y1"]
      end

      def make_dictionary_into_hash(dictionary)
        dict_hash = {}
        dictionary.each do |line|
          array = line.split("  ")
          if array[1]
            array[1] = array[1].split(" ")
          end
          dict_hash[array[0]] = array[1]
        end
        return dict_hash
      end

      def get_data_from_url(url)
        url = url
        data = open(url).read
        return data
      end
end

data = GetData.new

while true
  system "clear"
  puts "What word do you want to rhyme?"
  print "> "
  word = gets.chomp
  puts "-" * 50
  puts data.get_rhyming_words(word)
  puts "-" * 50
  puts "Again (y/n)?"
  print "> "
  answer = gets.chomp.downcase
  if answer == "n" || answer == "no"
    break
  end
end
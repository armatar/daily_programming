require 'byebug'

class DetectAlliteration
  attr_reader :lines_to_parse, :input_to_parse, :stop_words

  def get_stop_words(file_path)
   @stop_words = get_array_from_file(file_path, true)
  end

  def get_input_to_parse(file_path)
    raw_input = get_array_from_file(file_path, false)
    @lines_to_parse = raw_input.shift
    @input_to_parse = raw_input
  end

  def find_alliteration(lines_to_parse, input_to_parse, stop_words)
    cleaned_input = input_to_parse.slice(0..lines_to_parse.to_i-1)
    cleaned_input = cut_out_stop_words(cleaned_input, stop_words)
    cleaned_input = check_for_first_letter(cleaned_input)
    puts cleaned_input.inspect
  end

  private

    def check_for_first_letter(cleaned_input)
      cleaned_input.each_with_index do | line, index |
        prev_word = "."
        alliteration_list = []
        words = line.split(" ")
        words.reverse!
        words.each do | word |
          if word[0].downcase == prev_word[0].downcase
            if !alliteration_list.include?(prev_word)
              alliteration_list.push(prev_word)
            end
            if !alliteration_list.include?(word)
              alliteration_list.push(word)
            end
          end
          prev_word = word
        end
        alliteration_list.reverse!
        cleaned_input[index] = alliteration_list.join(" ")
      end
      return cleaned_input
    end

    def cut_out_stop_words(cleaned_input, stop_words)
      stop_words.each do | word_to_cut_out |
        cleaned_input.each_with_index do | line, index |
          words = line.split(" ")
          words.delete(word_to_cut_out)
          cleaned_input[index] = words.join(" ")
        end
      end
      return cleaned_input
    end

    def get_array_from_file(file_path, trim_spaces)
      array_from_file = []
      File.open(file_path, "r") do |f|
        f.each_line do |line|
          if trim_spaces
            line = line.tr(" ", '')
          end
          array_from_file.push(line.tr("\n", ''))
        end
      end
      return array_from_file
    end




end


detect = DetectAlliteration.new
detect.get_stop_words("stop_words.txt")
detect.get_input_to_parse("sample_input.txt")
detect.find_alliteration(detect.lines_to_parse, detect.input_to_parse, detect.stop_words)

detect.get_input_to_parse("challenge_input.txt")
detect.find_alliteration(detect.lines_to_parse, detect.input_to_parse, detect.stop_words)
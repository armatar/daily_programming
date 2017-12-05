require_relative 'metro_map.rb'

def get_path(metro_map, start, destination)
  possible_paths = {}
  count = 0
  metro_map.each do |path|
    if path[:station1] == start
      if path[:station2] == destination
        possible_paths[count] = [path]
        count += 1
      else
        start2 = path[:station2]
        metro_map.each do |path2|
          if path2[:station1] == start2 && path2[:station2] == destination
            possible_paths[count] = [path, path2]
            count += 1
          end
        end
      end
    end
  end
  return possible_paths
end

def format_answer(paths_hash)
  answer = ""
  if paths_hash.length == 0
    answer = "There are no options found with one minimum change."
  else
    paths_hash.each_pair do |number, paths|
      answer += "Option #{number} : At #{paths[0][:station1]}, take #{paths[0][:color1]} line"
      if paths.length == 1
        answer += " exit at #{paths[0][:station2]}.\n"
      else
        answer += ", change at #{paths[0][:station2]} and take #{paths[1][:color1]} line exit at #{paths[1][:station2]}.\n"
      end
    end
  end
  return answer
end

metro_map = MetroMap.metro_map

start = "A"
destination = "B"

puts format_answer(get_path(metro_map, start, destination))
#!/usr/bin/env ruby

require 'open-uri'
require 'json'
require 'paint'
require_relative "url_by_type.rb"

class GetJsonHash

  include UrlByType

  def get_json_hash(element)

    # Construct the URL we'll be calling
    @element_name = element
    request_uri = get_url(@element_name)
    request_query = ''
    url = "#{request_uri}#{request_query}"

    # Actually fetch the contents of the remote URL as a String.
    buffer = open(url).read

    @json_hash = JSON.parse(buffer)
    get_damage_info_from_hash
  end

  def get_damage_info_from_hash
    @half_damage_from = @json_hash["damage_relations"]["half_damage_from"]
    @no_damage_from = @json_hash["damage_relations"]["no_damage_from"]
    @half_damage_to = @json_hash["damage_relations"]["half_damage_to"]
    @double_damage_from = @json_hash["damage_relations"]["double_damage_from"]
    @no_damage_to = @json_hash["damage_relations"]["no_damage_to"]
    @double_damage_to = @json_hash["damage_relations"]["double_damage_to"]
  end

  def print_details
    puts "-" * 50
    puts Paint["Element: ", :bold, :red] + Paint[@element_name.capitalize, :bold]
    puts "-" * 50
    puts Paint["half damage from: ", :bold]
    @half_damage_from.each do | line |
      puts "=> " + line["name"]
    end
    puts "-" * 30
    puts Paint["no damage from: ", :bold]
    @no_damage_from.each do | line |
      puts "=> " + line["name"]
    end
    puts "-" * 30
    puts Paint["half damage to: ", :bold]
    @half_damage_to.each do | line |
      puts "=> " + line["name"]
    end
    puts "-" * 30
    puts Paint["double damage from: ", :bold]
    @double_damage_from.each do | line |
      puts "=> " + line["name"]
    end
    puts "-" * 30
    puts Paint["no damage to: ", :bold]
    @no_damage_to.each do | line |
      puts "=> " + line["name"]
    end
    puts "-" * 30
    puts Paint["double damage to: ", :bold]
    @double_damage_to.each do | line |
      puts "=> " + line["name"]
    end
    puts "-" * 30
  end

  def get_element
    continue = "yes"
    while continue == "yes"
      puts "What element do you want to know about?"
      print "> "
      element = gets.chomp.downcase
      check = get_number_associated_with_type
      if check[element]
        get_json_hash(element)
        system "clear"
        print_details
        puts "Another? (yes|no)"
        print "> "
        continue = gets.chomp.downcase
      else
        puts "Invalid submission."
      end
    end
  end
end

get_hash = GetJsonHash.new
get_hash.get_element

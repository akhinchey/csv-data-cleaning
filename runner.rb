require "csv"
require_relative "entry"



def parse(filename, arr_or_entries)
  CSV.foreach(filename, :headers => true, :header_converters => :symbol).map do |row|
      arr_or_entries << Entry.new(row.to_hash)
  end
end


def save(filename, arr_or_entries)
  CSV.open(filename, "wb") do |csv|
    csv << ["id", "description"]
    arr_or_entries.each do |entry|
      csv << [entry.id, entry.description]
    end
  end
end

def check_first_words(arr_of_entries)
  arr_of_entries.each do |entry|
    first_word = entry.description.split(" ")[0]
    if first_word == "Provides" || 
      first_word == "Offers" ||
      first_word == "A" ||
      first_word == "An" ||
      first_word == "Provide" ||
      first_word == "Program" ||
      first_word == "Offer" ||
      first_word[-1] == "s"
      entry.description.capitalize!
    end
  end
end

def check_first_and_second_words(arr_of_entries)
  arr_of_entries.each do |entry|
    first_word = entry.description.split(" ")[0]
    second_word = entry.description.split(" ")[1]

    if first_word + " " + second_word == "Support Group" 
      entry.description.capitalize!
    end
  end
end

def check_for_mid_keywords(arr_of_entries)
  words_to_check_for = ["Provides", "Is", "Offers", "Offer", "Serves", "Sells", "Helps", "Strives", "Distributes", "Handles", "Assists"]
  arr_of_entries.each do |entry|
    words = entry.description.split(" ")
    key_word = words.find { |word| words_to_check_for.include?(word) }

    if key_word && words.index(key_word) != 0 && words.index(key_word) < 6
      index = words.index(key_word)
      entry.description = words[0...index].join(" ") + " " + words[index..-1].join(" ").downcase
    end
  end
end







entries = []

parse("jr_data_engineer_assignment.csv", entries)

title_cased_entries = entries.select { |entry| entry.is_title_cased? }


check_first_words(title_cased_entries)
check_first_and_second_words(title_cased_entries)
check_for_mid_keywords(title_cased_entries)



p title_cased_entries.size
p title_cased_entries.select { |entry| entry.is_title_cased? }.count

title_cased_entries.select { |e| e.is_title_cased? }.each do |e|
    e.description.capitalize!
  end


# title_cased_entries.select { |entry| entry.description.include?("provides")}.each do |entry|
#     puts entry.description
#   end
title_cased_entries.each {|entry| puts entry.description}

save("practice.csv", title_cased_entries)

# the...
# is
# provides
# offers
# "acronyms" - how to detect





# 2.1.2 :025 > arr = "Hello World Provides Some Kind Of Service"
#  => "Hello World Provides Some Kind Of Service" 
# 2.1.2 :026 > arr = arr.split(" ")
#  => ["Hello", "World", "Provides", "Some", "Kind", "Of", "Service"] 
# 2.1.2 :027 > split_index = arr.index("Provides")
#  => 2 
# 2.1.2 :028 > split_index
#  => 2 
# 2.1.2 :029 > arr[0...split_index].join(" ")
#  => "Hello World" 
# 2.1.2 :030 > arr[0...split_index].join(" ") + arr[split_index..-1].join(" ")
#  => "Hello WorldProvides Some Kind Of Service" 
# 2.1.2 :031 > arr[0...split_index].join(" ") + " " + arr[split_index..-1].join(" ").downcase
#  => "Hello World provides some kind of service"


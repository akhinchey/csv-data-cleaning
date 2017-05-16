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

def check_for_periods(arr_of_entries)
  arr_of_entries.each do |entry|
    sentences = entry.description.split(". ")
    sentences.each do |sentence|
      sentence[0] = sentence[0].upcase
    end
    entry.description = sentences.join(". ")
  end
end

def capitalize_remainder(arr_of_entries)
  arr_of_entries.select { |entry| entry.is_title_cased? }.each do |entry|
      entry.description.capitalize!
    end
end

def upcase_acronyms(arr_of_entries)
  acronyms = ["NYC", "GED", "HIV", "AIDS", "CPR"]
  arr_of_entries.each do |entry|
    words = entry.description.split(" ")
    words.each do |word|
      if acronyms.any? { |acronym| word.upcase == acronym }
        entry.description.gsub!(word, word.upcase)
      end
    end
  end
end

def capitalize_words(arr_of_entries)
  words_to_check_for = [ "Sunday",
                          "Monday",
                          "Tuesday",
                          "Wednesday",
                          "Thursday",
                          "Friday",
                          "Jesus",
                          "Christ",
                          "Baptist",
                          "Medicaid",
                          "Medicare"
                          ]
  arr_of_entries.each do |entry|
  end
end





entries = []

parse("jr_data_engineer_assignment.csv", entries)

title_cased_entries = entries.select { |entry| entry.is_title_cased? }


check_first_words(title_cased_entries)

check_first_and_second_words(title_cased_entries)

check_for_mid_keywords(title_cased_entries)

capitalize_remainder(title_cased_entries)

check_for_periods(title_cased_entries)

upcase_acronyms(title_cased_entries)

title_cased_entries.each {|entry| puts entry.description}

# save("practice.csv", title_cased_entries)






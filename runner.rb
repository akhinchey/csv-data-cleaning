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

def first_words(arr_of_entries)
  arr_of_entries.each do |entry|
    entry.check_first_words 
  end
end

def first_and_second_words(arr_of_entries)
  arr_of_entries.each do |entry|
    entry.check_first_and_second_words
  end
end

def check_mid_keywords(arr_of_entries)
  arr_of_entries.each do |entry|
    entry.check_for_mid_keywords
  end
end

def check_for_periods(arr_of_entries)
  arr_of_entries.each do |entry|
    entry.capitalize_sentences
  end
end

# method stays in runner(?)
def capitalize_remainder(arr_of_entries)
  arr_of_entries.select { |entry| entry.is_title_cased? }.each do |entry|
      entry.capitalize
    end
end

def up_acronyms(arr_of_entries)
  arr_of_entries.each do |entry|
    entry.upcase_acronyms
  end
end

def cap_words(arr_of_entries)
  arr_of_entries.each do |entry|
    entry.capitalize_words
  end
end





entries = []

parse("jr_data_engineer_assignment.csv", entries)

title_cased_entries = entries.select { |entry| entry.is_title_cased? }


first_words(title_cased_entries)

first_and_second_words(title_cased_entries)

check_mid_keywords(title_cased_entries)

capitalize_remainder(title_cased_entries)

check_for_periods(title_cased_entries)

up_acronyms(title_cased_entries)

cap_words(title_cased_entries)

title_cased_entries.each {|entry| puts entry.description}

# save("practice.csv", title_cased_entries)






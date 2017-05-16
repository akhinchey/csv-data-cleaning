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

def clean_descriptions(arr_of_entries)
  arr_of_entries.each do |entry|
    entry.check_first_words
    entry.check_first_and_second_words
    entry.check_for_mid_keywords
    entry.capitalize if entry.is_title_cased?
    entry.capitalize_sentences
    entry.upcase_acronyms
    entry.capitalize_words
  end
end



entries = []

parse("jr_data_engineer_assignment.csv", entries)

title_cased_entries = entries.select { |entry| entry.is_title_cased? }

clean_descriptions(title_cased_entries)

title_cased_entries.each {|entry| puts entry.description}

# save("practice.csv", title_cased_entries)






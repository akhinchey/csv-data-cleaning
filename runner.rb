require "csv"
require_relative "entry"


def run(filename)
  entries = parse(filename)
  entries.each do |entry|
    if entry.is_title_cased?
      clean_description(entry) 
    end
  end
  save(filename, entries)
end


def parse(filename)
  CSV.foreach(filename, :headers => true, :header_converters => :symbol).map do |row|
      Entry.new(row.to_hash)
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


def clean_description(entry)
    entry.check_first_words
    entry.check_first_and_second_words
    entry.check_for_mid_keywords
    entry.capitalize if entry.is_title_cased?
    entry.capitalize_sentences
    entry.upcase_acronyms
    entry.capitalize_words
end



run("jr_data_engineer_assignment.csv")








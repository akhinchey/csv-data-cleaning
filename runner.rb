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

entries = []

parse("jr_data_engineer_assignment.csv", entries)

type_cased_entries = entries.select { |entry| entry.is_type_cased? }

type_cased_entries.each do |entry|
  first_word = entry.description.split(" ")[0]
  if first_word == "Provides" || 
    first_word == "Offers" ||
    first_word == "A"
    entry.description.capitalize!
  end
end 

type_cased_entries.each {|entry| puts entry.description}

p type_cased_entries.select { |entry| entry.is_type_cased? }.count

# save("jr_data_engineer_assignment.csv", entries)


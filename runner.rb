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

# entries = []

# parse("jr_data_engineer_assignment.csv", entries)

# entries.each { |entry| entry.description.upcase! }

# save("jr_data_engineer_assignment.csv", entries)


require "csv"
require_relative "entry"

def parse(filename)
  CSV.foreach(filename, :headers => true, :header_converters => :symbol).map do |row|
      entry = Entry.new(row.to_hash)
      p entry 
  end
end

parse("jr_data_engineer_assignment.csv")
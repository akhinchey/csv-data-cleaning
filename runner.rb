require "csv"

def parse(filename)
  CSV.foreach(filename, :headers => true, :header_converters => :symbol).map do |row|
      p row.to_hash
  end
end

parse("jr_data_engineer_assignment.csv")
class Entry

  attr_reader :id
  attr_accessor :description

  def initialize(args={})
    @id = args.fetch(:id, "")
    @description = args.fetch(:description, "")
  end

  def is_type_cased?
    description.split(" ").each do |word|
      return false if word != word.capitalize
    end
    true
  end

end
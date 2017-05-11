class Entry

  attr_reader :id
  attr_accessor :description

  def initialize(args={})
    @id = args.fetch(:id, "")
    @description = args.fetch(:description, "")
  end

end
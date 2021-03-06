class Entry

  attr_reader :id
  attr_accessor :description


  def initialize(args={})
    @id = args.fetch(:id, "")
    @description = args.fetch(:description, "")
  end


  def is_title_cased?
    description.split(" ").each do |word|
      return false if word != word.capitalize
    end
    true
  end

  def get_words
    description.split(" ")
  end


  def check_first_words
    words_to_check_for = [ "Provide",
                            "Offer",
                            "A",
                            "An",
                            "Program",
                            "This"
                          ]

    first_word = get_words[0]
    if words_to_check_for.any? {|check_word| check_word == first_word } || first_word[-1] == "s"
      description.capitalize!
    end
  end


  def check_first_and_second_words
    first_word, second_word = get_words[0], get_words[1]

    if first_word + " " + second_word == "Support Group" 
      description.capitalize!
    end
  end


  def check_for_mid_keywords
    words_to_check_for = [ "Provides", 
                            "Is", 
                            "Offers", 
                            "Offer", 
                            "Serves", 
                            "Sells", 
                            "Helps", 
                            "Strives", 
                            "Distributes", 
                            "Handles", 
                            "Assists"
                          ]

    get_words[1..7].each do |word|
      if words_to_check_for.any? { |check_word| word.include?(check_word) }
        index = get_words.index(word)
        @description = get_words[0...index].join(" ") + " " + get_words[index..-1].join(" ").downcase
        break
      end
    end
  end


  def capitalize
    description.capitalize!
  end


  def capitalize_sentences
    sentences = description.split(". ")
    sentences.each do |sentence|
      sentence[0] = sentence[0].upcase
    end
    @description = sentences.join(". ")
  end


  def upcase_acronyms
    acronyms = [  "NYC", 
                  "GED", 
                  "HIV", 
                  "AIDS", 
                  "CPR",
                  "NYS",
                  "USDA",
                  "MS"
                ]

      get_words.each do |word|
        if acronyms.any? { |acronym| word.upcase == acronym }
          description.gsub!(word, word.upcase)
        end
      end
  end


  def capitalize_words
    words_to_check_for = [ "Sunday",
                            "Monday",
                            "Tuesday",
                            "Wednesday",
                            "Thursday",
                            "Friday",
                            "Saturday",
                            "Jesus",
                            "Christ",
                            "Baptist",
                            "Catholic",
                            "Lutheran",
                            "Medicaid",
                            "Medicare",
                            "English"
                            ]

    get_words.each do |word|
      if words_to_check_for.any? { |cap_word| word.capitalize.include?(cap_word) }
        description.gsub!(word, word.capitalize)
      end
    end
  end


end
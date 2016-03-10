
#dispayvalue (above 10 is a j k q)
#display rank (above 10 is 10)

class Card
  attr_accessor :suit, :value, :card
  def initialize (suit, value)
    @suit = suit
    @value = value
    @card = [suit, value]
  end

  def display_rank
    case @value
    when  11
      return "J"
    when 12
      return "Q"
    when 13
      return "K"
    when 14
      return "A"
    else
      return @value
    end
  end

  def display_value
    case @value
    when  14
      return 11
    when (10..13)
      return 10
    else
      return @value
    end
  end
end

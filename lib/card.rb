
#dispayvalue (above 10 is a j k q)
#display rank (above 10 is 10)

class Card
  attr_accessor :suit, :value, :card
  def initialize (suit, value)
    @suit = suit
    @value = value
    @card = [suit, value]
  end

  def display_value
    case @value
    when @value == 11
      @value = "J"
    when @value == 12
      @value = "Q"
    when @value == 13
      @value = "K"
    when @value == 14
      @value = "A"
    end
  end
  
    def display_rank
      if @value < 10
        @value = 10
      elsif @value == 14
        @value = 11
      end
    end
end

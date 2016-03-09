require_relative "../lib/card.rb"
require_relative "../lib/deck.rb"

def dance_with_em
  puts "So you want to play a game."
  puts "Type (play) to begin or else (quit) to leave"
  choice = gets.chomp.upcase
  if choice == "PLAY"
    puts "We playin'"
  elsif choice == "QUIT"
    puts "Good-bye"
  else
    puts "That was neither play or quit."
    dance_with_em
  end
end

class PlayBlackjack
  dance_with_em
  deck = Deck.new
end

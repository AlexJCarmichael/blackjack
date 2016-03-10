require_relative "../lib/card.rb"
require_relative "../lib/deck.rb"

class Player (name)
  def initialize
    @name = name
  end
end

def dance_with_em
  puts "So you want to play a game."
  puts "Type (play) to begin or else (quit) to leave"
  choice = gets.chomp.upcase
  if choice == "PLAY"
    puts "We playin'"
    @busted_status = "no"
    @computer_busted = "no"
  elsif choice == "QUIT"
    puts "Good-bye"
    exit
  else
    puts "That was neither play or quit."
    dance_with_em
  end
end

def deal_cards(hand, deck)
  card = hand.push(deck.draw_card)
  card_two = hand.push(deck.draw_card)
end

def display_hand(hand)
  hand.each do |x|
    print "#{x.display_rank} #{x.suit} "
  end
  puts
end

def calc_hand (hand)
  amount = 0
  hand.each do |x|
    amount += x.display_value
  end
  return amount
end

def make_a_move (hand, deck)
  puts "Do you want to hit or stand?"
  answer = gets.chomp.upcase
  if answer == "HIT"
    card = hand.push(deck.draw_card)
  elsif answer == "STAND"
    @go_again = "no"
  else
    puts "Please select hit or stand."
    make_a_move(hand, deck)
  end
end

def check_busted(hand)
  amount = 0
  hand.each do |x|
    amount += x.display_value
  end
  if amount < 22
    @busted_status = "no"
  else
    @busted_status = "yes"
  end
end

def check_blackjack(hand, string)
  @player_black_jack = "no"
  amount = 0
  hand.each do |x|
    amount += x.display_value
  end
  if amount == 21 || amount == 22
    puts "Blackjack!"
    @go_again = "no"
    puts "#{string} has a Blackjack!"
    if string == "Player"
      @player_black_jack = "yes"
    elsif string == "Computer"
      @computer_black_jack = "yes"
    end
  end
end

def dealer_logic(hand, deck)
  if @player_black_jack == "yes"
    @dealer_score = 0
  elsif @computer_black_jack == "yes"
    puts "Dealer Wins!"
    give_space
  else
    print "*" * 20
    puts
    print "Dealer's turn!"
    puts
    print "*" * 20
    puts
    print "Dealer: "
    display_hand(hand)
    check_blackjack(hand, "Computer")
    give_space
    amount = calc_hand(hand)
    print "Dealer hand: "
    display_hand(hand)
    give_space
    while amount < 16
      card = hand.push(deck.draw_card)
      puts "Dealer hits!"
      give_space
      display_hand(hand)
      give_space
      amount = calc_hand(hand)
    end
    puts "Dealer stands."
    @dealer_score = amount
    if amount < 22
      puts "Dealer has #{amount}"
      @dealer_score = amount
    elsif amount >= 22
      puts "Dealer has #{amount}."
      puts "Dealer busts!"
      @dealer_score = amount
      @computer_busted = "yes"
    else
      puts "Tim Allen noise."
    end
  end
end

def show_dealer_hand(hand)
  print "Dealer hand is... "
  print "#{hand.first.display_rank} #{hand.first.suit} 🂠 \n"
  give_space
end

def determine_winner(c_score, score)
  if @player_black_jack == "yes"
    puts "Player wins!"
  elsif @computer_black_jack == "yes"
    puts "Computer wins!"
  elsif @busted_status == "yes" && @computer_busted == "yes"
    puts "It's a draw."
  elsif @busted_status == "yes"
    puts "Computer wins!"
  elsif @computer_busted == "yes"
    puts "Player wins!"
  elsif score > c_score
    puts "Player wins!"
  elsif c_score > score
    puts "Computer wins!"
  elsif score == c_score
    puts "The game is a draw."
  else
    puts "Tim Allen noise"
  end
end

def give_space
  print "-" * 30
  print "\n"
end

class PlayBlackjack
    loop do
    dance_with_em
    deck = Deck.new
    deck.shuffle_up
    hand = []
    dealer_hand = []
    @go_again = "yes"
    @busted_status = "no"
    deal_cards(hand, deck)
    deal_cards(dealer_hand, deck)
    show_dealer_hand(dealer_hand)
    print "Players hand: "
    display_hand(hand)
    give_space
    check_blackjack(hand, "Player")
    puts "Player has: #{calc_hand(hand)}"
    while @busted_status == "no" && @go_again == "yes"
      @player_score = calc_hand(hand)
      make_a_move(hand, deck)
      give_space
      @player_score = calc_hand(hand)
      print "Players hand: "
      display_hand(hand)
      give_space
      puts "Player has: #{calc_hand(hand)}"
      give_space
      check_busted(hand)
    end
    dealer_logic(dealer_hand, deck)
    determine_winner(@dealer_score, @player_score)
  end
end

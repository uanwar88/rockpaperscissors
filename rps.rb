require 'pry'

class Player
  # Public: Initialize
  # Set initial values for the Player object
  #
  # Params:
  # + name: Name of the player
  # + score: initial score
  #
  # Returns:
  # nil
  #
  # State changes:
  # Sets the name and score attributes
  
  attr_accessor :name, :score, :move
  def initialize(name,score=0)
    @name = name
    @score = score
  end
end

def make_move
  rps = ['rock','paper','scissors']
  rps.sample
end

def play_round(player1,player2)
  # Description: Plays a round of RPS and decides a winner. The players make a random move. The winner is given a point.
  #
  # Params:
  # + player1: A player1 object.
  # + player2: A player2 object.
  #
  # Returns:
  # Returns the player object that wins, or nil if it's a tie.
  
  rules = { 'rock' => 'scissors', 'paper' => 'rock', 'scissors' => 'paper' }
  
  player1.move = make_move
  puts "#{player1.name} throws #{player1.move}"
  player2.move = make_move
  puts "#{player2.name} throws #{player2.move}"
  
  if rules[player1.move] == player2.move
    puts "#{player1.name} wins the round!"
    player1.score += 1
    return player1
  elsif player1.move == player2.move
    puts "Tie!"
    return nil
  else
    puts "#{player2.name} wins the round!"
    player2.score += 1
    return player2
  end
end

def create_players(p1,p2)
  # Description: Creates and returns two player objects.
  # Params:
  # + p1: A player name string.
  # + p2: A player name string.
  
  return Player.new(p1), Player.new(p2)
end

def display_scores(*players)
  # Description: Displays player scores.
  # Params:
  # + *players: A list of player objects.
  
  players.each {|x| puts "#{x.name}: #{x.score}"}
  return players
end

def display_winner(player1, player2)
  # Description: Outputs the winner to the terminal.
  # Params:
  # + player1: player1 object.
  # + player2: player2 object.
  
  puts player1.score > player2.score ? "#{player1.name} wins the match!" : "#{player2.name} wins the match!"
end

def match(p1,p2,best_of)
  best_of.odd? ? win_score = (best_of/2.to_f).ceil : win_score = ((best_of-1)/2.to_f).ceil
  
  player1, player2 = create_players(p1,p2)
  
  #Have the player1 and player2 objects play a round until one of them wins
  until player1.score == win_score || player2.score == win_score
    play_round(player1,player2)
  end  
  
  puts "Final scores:"
  display_scores(player1,player2)  
  display_winner(player1,player2)
end

match("Joe","Sam",5)
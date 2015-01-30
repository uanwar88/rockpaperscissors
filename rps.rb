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
  
  def make_move
    @move = ['rock','paper','scissors'].sample
  end
end

class Game
  def self.create_players(p1,p2)
    # Description: Creates and returns two player objects.
    # Params:
    # + p1: A player name string.
    # + p2: A player name string.
  
    return Player.new(p1), Player.new(p2)
  end

  def self.display_scores(*players)
    # Description: Displays player scores.
    # Params:
    # + *players: A list of player objects.
  
    players.each {|x| puts "#{x.name}: #{x.score}"}
    puts ""
    return players
  end

  def self.display_match_winner(player1, player2)
    # Description: Outputs the winner to the terminal.
    # Params:
    # + player1: player1 object.
    # + player2: player2 object.
  
    puts player1.score > player2.score ? "#{player1.name} wins the match!" : "#{player2.name} wins the match!"
  end

  def self.match(game,p1,p2,best_of)
    best_of.odd? ? win_score = (best_of/2.to_f).ceil : win_score = ((best_of-1)/2.to_f).ceil
  
    player1, player2 = create_players(p1,p2)
  
    # Have the player1 and player2 objects play a round until one of them wins
    until player1.score == win_score || player2.score == win_score
      game.play_round(player1,player2)
    end  
  
    puts "Final scores:"
    display_scores(player1,player2)  
    display_match_winner(player1,player2)
  end
end

class RPS
  def self.play_round(player1,player2)
    # Description: Plays a round of RPS and decides a winner. The players make a random move. The winner is given a point.
    #
    # Params:
    # + player1: A player1 object.
    # + player2: A player2 object.
    #
    # Returns:
    # Returns the player object that wins, or nil if it's a tie.
  
    player1.make_move
    puts "#{player1.name} throws #{player1.move}"
    player2.make_move
    puts "#{player2.name} throws #{player2.move}"
  
    winner = determine_winner(player1,player2)
  
    puts winner ? "#{winner.name} wins the round!" : "Tie!"
    puts ""
  end

  def self.determine_winner(player1,player2)
    # Description: Determines the winner resulting from two player moves.
    # Params:
    # + player1: A player1 object.
    # + player2: A player2 object.
    # Returns:
    # The player object that won the round.
  
    rules = { 'rock' => 'scissors', 'paper' => 'rock', 'scissors' => 'paper' }
  
    if rules[player1.move] == player2.move
      player1.score += 1
      return player1
    elsif player1.move == player2.move
      return nil
    else
      player2.score += 1
      return player2
    end
  end
end

Game.match(RPS,"Joe","Sam",5)
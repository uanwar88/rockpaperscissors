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
  
  def make_move(game)
    print "List of moves: ", game.moves, "\n"
    puts "#{name} throws: "
    @move = gets.chomp
    puts "#{self.name} made a move!", ""
  end
end

class AI < Player
  def make_move(game)
    @move = game.moves.sample
    puts "#{self.name} made a move!", ""
  end
end

class Game
  def self.create_players(p1, p2)
    # Description: Creates and returns two player objects.
    # Params:
    # + p1: A player name string.
    # + p2: A player name string.
    if p1[0,2] == "AI" && p2[0,2] == "AI"
      return AI.new(p1), AI.new(p2)
    elsif p1[0,2] == "AI"
      return AI.new(p1), Player.new(p2)
    elsif p2[0,2] == "AI"
      return Player.new(p1), AI.new(p2)
    else
      return Player.new(p1), Player.new(p2)
    end
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
    best_of.odd? ? win_score = (best_of / 2) + 1 : win_score = (best_of / 2) + 1
    
    if p1 == p2
      p1 = p1 + "_1"
      p2 = p2 + "_2"
    end
  
    player1, player2 = create_players(p1,p2)
  
    # Have the player1 and player2 objects play a round until one of them wins
    round = 1
    until player1.score == win_score || player2.score == win_score
      puts "Round #{round}!"
      game.play_round(player1,player2)
      round += 1
    end  
  
    puts "Final scores:"
    display_scores(player1,player2)  
    display_match_winner(player1,player2)
  end
end

class RPS
  def self.moves  
    @moves = ['rock','paper','scissors']
  end
  
  def self.play_round(player1,player2)
    # Description: Plays a round of RPS and decides a winner. The players make a random move. The winner is given a point.
    #
    # Params:
    # + player1: A player1 object.
    # + player2: A player2 object.
    #
    # Returns:
    # Returns the player object that wins, or nil if it's a tie.
  
    player1.make_move(self)    
    player2.make_move(self)
  
    winner = determine_winner(player1,player2)
    
    puts "#{player1.name} threw #{player1.move}. #{player2.name} threw #{player2.move}."
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

Game.match(RPS,"AI_Joe","AI_Sam",3)
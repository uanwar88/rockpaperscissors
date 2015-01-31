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
  
  def make_move(moves)
    Outputter.put "#{name} throws: "
    @move = Moves_handler.verify(nil,moves)
    Outputter.put "#{self.name} made a move!\n"
  end
end

class AI < Player
  def make_move(moves)
    @move = moves.sample
    Outputter.put "#{self.name} made a move!\n"
  end
end

class Game
  def self.file
    @file
  end
  
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
  
    players.each {|x| Outputter.put "#{x.name}: #{x.score}"}
    Outputter.put ""
    return players
  end

  def self.display_match_winner(player1, player2)
    # Description: Outputs the winner to the terminal.
    # Params:
    # + player1: player1 object.
    # + player2: player2 object.
  
    player1.score > player2.score ? Outputter.put("#{player1.name} wins the match!") : Outputter.put("#{player2.name} wins the match!")
  end

  def self.match(game,file=0,p1,p2,best_of)    
    if p1 == p2
      p1 = p1 + "_1"
      p2 = p2 + "_2"
    end
  
    player1, player2 = create_players(p1,p2)
    
    #creates a new file for output if the argument is given
    if file == 1
      filename = "#{game.title}_#{player1.name}_#{player2.name}.txt"
      @file = File.open(filename, "w")
    end
  
    # Have the player1 and player2 objects play a round until one of them wins
    best_of.odd? ? win_score = (best_of / 2) + 1 : win_score = (best_of / 2) + 1
    round = 1
    until player1.score == win_score || player2.score == win_score
      Outputter.put("Round #{round}!")
      game.play_round(player1,player2)
      round += 1
    end  
  
    Outputter.put "Final scores:"
    display_scores(player1,player2)  
    display_match_winner(player1,player2)
    
    if Game.file
      @file.close
    end
  end
end

class RPS
  def self.title
    "RPS"
  end
  
  def self.moves  
    ['rock','paper','scissors']
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
  
    player1.make_move(self.moves)    
    player2.make_move(self.moves)
  
    winner = determine_winner(player1,player2)
    
    Outputter.put "#{player1.name} threw #{player1.move}. #{player2.name} threw #{player2.move}."
    winner ? Outputter.put("#{winner.name} wins the round!") : Outputter.put("Tie!")
    Outputter.put ""
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

class RPSLS
  def self.title
    "RPSLS"
  end
  
  def self.moves  
    ['rock','paper','scissors','lizard','spock']
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
  
    player1.make_move(self.moves)    
    player2.make_move(self.moves)
  
    winner = determine_winner(player1,player2)
    
    Outputter.put "#{player1.name} threw #{player1.move}. #{player2.name} threw #{player2.move}."
    Outputter.put winner ? "#{winner.name} wins the round!" : "Tie!"
    Outputter.put ""
  end

  def self.determine_winner(player1,player2)
    # Description: Determines the winner resulting from two player moves.
    # Params:
    # + player1: A player1 object.
    # + player2: A player2 object.
    # Returns:
    # The player object that won the round.
  
    rules = { 'rock' => 'scissors', 'paper' => 'rock', 'scissors' => 'paper', 'lizard' => 'paper', 'spock' => 'rock' }
    rules2 = { 'rock' => 'lizard',  'paper' => 'spock', 'scissors' => 'lizard', 'lizard' => 'spock', 'spock' => 'scissors' }
  
    if rules[player1.move] == player2.move || rules2[player1.move] == player2.move
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

class Moves_handler
  def self.verify(move,moves)
    loop do
      print "Select a valid move from the list: #{moves}\n"
      move = gets.chomp
      break if moves.index(move)
    end
    return move
  end
end

class Outputter
  def self.put(string)
    if Game.file
      Game.file.puts string
      puts string
    else
      puts string
    end
  end
end
  

Game.match(RPSLS,1,"AI_Usman","AI_Sam",3)
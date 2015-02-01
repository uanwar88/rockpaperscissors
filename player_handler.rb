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
    Outputter.put "#{name} moves: "
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

class Create_Players  
  def self.create(players)
    # Description: Creates and returns two player objects.
    # Params:
    # + p1: A player name string.
    # + p2: A player name string.
    player_id = 1
    for i in 0..players.length-1
      players[i] = players[i] + "_#{player_id}"
      player_id += 1
    end
    
    player_objects = []
    
    players.each do |x| 
      if x[0,2] == "AI"
        player_objects << AI.new(x)
      else
        player_objects << Player.new(x)
      end
    end
    
    return player_objects
  end
end

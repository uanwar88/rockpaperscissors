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
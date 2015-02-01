class RPS
  @moves = ['rock','paper','scissors']
  
  def self.round
    @round
  end
  
  def self.round=(x)
    @round = x
  end    
  
  def self.title
    "RPS"
  end
  
  def self.moves  
    @moves
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
    Outputter.put "Round #{@round}!"
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
  @moves = ['rock','paper','scissors','lizard','spock']
  
  def self.title
    "RPSLS"
  end
  
  def self.moves  
    @moves
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

class TTT
  @moves = [[0,0],[0,1],[0,2],[1,0],[1,1],[1,2],[2,0],[2,1],[2,2]]
  @board = Array.new(3) { Array.new (3) {"_"} }
  
  def self.round
    @round
  end
  
  def self.round=(x)
    @round = x
  end  
  
  def self.title
    "TTT"
  end
  
  def self.moves
    @moves
  end
  
  def check_board
  end
  
  def self.play_round(player1,player2)
    puts "Here's the board:"
    print "#{@board[0]} \n"
    print "#{@board[1]} \n"
    print "#{@board[2]} \n"
    
    puts "Available moves: "
    @moves.each { |i| print "#{i}\n" }
    player1.make_move(@moves)
    puts "#{player1.name} chose #{player1.move}!", ""
    @moves.delete(player1.move)  
    @board[player1.move[0]][player1.move[1]] = "o"
    
    
  end  
end


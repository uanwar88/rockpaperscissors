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
    Outputter.put "Round #{@round}!"
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
  def self.round
    @round
  end
  
  def self.round=(x)
    @round = x
  end  
  
  def self.title
    "TTT"
  end
  
  def self.play_turn(player,num=0)
    puts "Here's the board:"
    print "#{@board[0]} \n"
    print "#{@board[1]} \n"
    print "#{@board[2]} \n"
    
    puts "It's #{player.name}'s turn!"
    puts "Available moves: "
    @moves.each { |i| print "#{i}\n" }
    
    #sends the available moves list to player, who makes a move
    player.make_move(@moves)
    puts "#{player.name} chose #{player.move}!", ""
    
    #deletes chosen move from available moves list and places move on board
    @moves.delete(player.move)
    if num == 1  
      @board[player.move[0]][player.move[1]] = "X"
    else
      @board[player.move[0]][player.move[1]] = "O"
    end
  end
  
  def self.check_board(player)
    if num == 1
      player.score += 1
      return 0
      if player.score == 3
        return 1
      end
    else
      player.score += 1
      return 1
    end
  end
  
  def self.play_round(player1,player2)
    #set new board and available moves list at beginning of round
    @moves = [[0,0],[0,1],[0,2],[1,0],[1,1],[1,2],[2,0],[2,1],[2,2]]
    @board = Array.new(3) { Array.new (3) {"_"} }
    Outputter.put "Round #{@round}!"
   
    #sets dummy 'win' variable
    win = 0    
    until win == 1
      play_turn(player1)
      win, winner = check_board(player1)
      if win == 0
        play_turn(player2)
        win, winner = check_board(player2)
      end
    end
  end  
end


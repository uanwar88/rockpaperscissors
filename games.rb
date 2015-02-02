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
  
  # def self.moves
  #   @moves
  # end
  
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
    player1.make_move(@moves)    
    player2.make_move(@moves)
  
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
  
  # def self.moves
  #   @moves
  # end
  
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
    player1.make_move(@moves)    
    player2.make_move(@moves)
  
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
  
  def self.show_board
    Outputter.put "Here's the board:"
    Outputter.put "#{@board[0]}"
    Outputter.put "#{@board[1]}"
    Outputter.put "#{@board[2]}"
    Outputter.put ""
  end
  
  def self.play_turn(player,player_num=0)
    show_board

    Outputter.put "Available moves: "
    @moves.each { |i| Outputter.put "#{i}" }

    #sends the available moves list to player, who makes a move
    player.make_move(@moves)
    Outputter.put "#{player.name} chose #{player.move}!"
    Outputter.put ""

    #deletes chosen move from available moves list and places move on board
    @moves.delete(player.move)
    if player_num == 1
      @board[player.move[0]][player.move[1]] = "X"
    else
      @board[player.move[0]][player.move[1]] = "O"
    end
  end
  
  def self.check_board(player,str)
    #assemble three in a row for checking
    row = Array.new(3, "")
    col = Array.new(3, "")
    diag1 = [""]
    diag2 = [""]
    for x in 0..2
      for y in 0..2
        row[x] += @board[x][y]
        col[x] += @board[y][x]
      end
      diag1[0] += @board[x][x]
    end
    diag2[0] = @board[0][2]+@board[1][1]+@board[2][0]
    
    #search for three in a row
    match_found = 0
    row.each {|x| 
      if x == str * 3
        match_found = 1
      end
    }
    col.each {|x| 
      if x == str * 3
        match_found = 1
      end
    }
    if diag1[0] == str * 3 || diag2[0] == str * 3
      match_found = 1
    end
    
    #handle a winning situation
    if match_found == 1
      show_board
      Outputter.put "#{player.name} got three in a row! #{player.name} wins the round!"
      Outputter.put ""
      player.score += 1
      win = 1
      winner = player
      return win, winner
    else
      win = 0
      winner = nil
      return win, winner
    end
  end
  
  def self.play_round(player1,player2)
    #set new board and available moves list at beginning of round
    @moves = [[0,0],[0,1],[0,2],[1,0],[1,1],[1,2],[2,0],[2,1],[2,2]]
    @board = Array.new(3) { Array.new (3) {"_"} }
    Outputter.put "Round #{@round}!"
   
    #sets dummy 'win' variable
    win = 0    
    until win == 1 || @moves == []
      play_turn(player1,1)
      win, winner = check_board(player1,"X")
      if win == 0
        if @moves == []
          Outputter.put "It looks like nobody got three in a row! Tie game!"
          Outputter.put ""
        end
        if @moves != []
          play_turn(player2)
          win, winner = check_board(player2,"O")
        end
      end
    end
  end  
end


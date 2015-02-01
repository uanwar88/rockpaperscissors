class Game
  def self.file
    @file
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
  
    if player1.score > player2.score
      Outputter.put("#{player1.name} wins the match!\n\n")
      return player1, player2
    else
      Outputter.put("#{player2.name} wins the match!\n\n")
      return player2, player1
    end
  end

  def self.play(game,best_of,file,player1,player2)    
    #creates a new file for output if the argument is given
    if file == 1
      filename = "#{game.title}_#{player1.name}vs#{player2.name}.txt"
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
    winner, loser = display_match_winner(player1,player2)
    return winner, loser
    
    if Game.file
      @file.close
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
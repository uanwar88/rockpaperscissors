require 'pry'
require_relative 'game_driver.rb'
require_relative 'games.rb'  
require_relative 'player_handler.rb'
require_relative 'tournament.rb'

class User
  def self.get_user_input
    #get tournament or game
    tournament = nil
    loop do
      Outputter.put "Would you like to play a game or a tournament?"
      Outputter.put "1. Tournament"
      Outputter.put "2. Game"
      tournament = gets.chomp.to_i
      if ![1,2].include?(tournament)
        puts "Please enter a valid choice!"
      end
      break if [1,2].include?(tournament)
    end
    
    if tournament == 2
      tournament = 0
    end
    
    #get which game
    game = nil
    loop do
      Outputter.put "Which game would you like to play?"
      Outputter.put "1. Rock, Paper, Scissors"
      Outputter.put "2. Rock, Paper, Scissors, Lizard, Spock"
      Outputter.put "3. Tic-Tac-Toe"
      game = gets.chomp.to_i
      if ![1,2,3].include?(game)
        puts "Please enter a valid choice!"
      end
      break if [1,2,3].include?(game)
    end
    
    if game == 1 
      game = RPS
    elsif game == 2
      game = RPSLS
    elsif game == 3
      game = TTT
    end
    
    Outputter.put "Each match should be a best of?"
    best_of = gets.chomp.to_i
    
    #specify file output
    req_file = nil
    loop do
      Outputter.put "Would you like file output?"
      Outputter.put "1. Yes"
      Outputter.put "2. No"
      req_file = gets.chomp.to_i
      if ![1,2].include? req_file
        puts "Please enter a valid choice!"
      end
      break if [1,2].include? req_file
    end
    
    if req_file == 2
      req_file == 0
    end
    
    players = []
    if tournament == 1
      Outputter.put "How many players in the tournament?"
      num_players = gets.chomp.to_i
      Outputter.put "Enter #{num_players} names:"
      num_players.times {|x| 
        x = gets.chomp
        players << x
      }
    else
      puts "Enter two player names:"
      2.times {|x| 
        x = gets.chomp 
        players << x
      }
    end
    
    return tournament, game, best_of, req_file, players
  end
  
  def self.play
    tournament, game, best_of, req_file, list_players = get_user_input
        
    if tournament == 1
      Launcher.tournament(game,best_of,req_file,list_players)
    else
      Launcher.game(game,best_of,req_file,list_players)
    end
  end
end

class Launcher
  def self.tournament(game,best_of,req_file,list_players)    
    players = Create_Players.create(list_players)
    
    Outputter.open(req_file,1,game.title)
    
    Tournament.play(game,best_of,players)
    
    Outputter.close
  end
  
  def self.game(game,best_of,req_file,list_players)    
    players = Create_Players.create(list_players)
        
    Outputter.open(req_file,0,game.title,players[0].name,players[1].name)
    
    Game.play(game,best_of,players[0],players[1])
    
    Outputter.close
  end
end

#Launcher.game(RPS,3,0,"AI_Usman","AI_Sam")

#Launcher.tournament(RPS,3,1,'AI_Usman','AI_Sam','AI_John','AI_Mark','AI_Joe')

#Launcher.game(RPS,3,1,'AI_Usman','AI_Sam')

User.play
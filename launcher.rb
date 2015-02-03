require 'pry'
require_relative 'game_driver.rb'
require_relative 'games.rb'  
require_relative 'player_handler.rb'
require_relative 'tournament.rb'

class Launcher
  def self.tournament(game,best_of,req_file,*list_players)    
    players = Create_Players.create(list_players)
    
    if req_file == 1
      Outputter.open(1,game.title)
    end
    
    Tournament.play(game,best_of,players)
    
    Outputter.close
  end
  
  def self.game(game,best_of,req_file,*list_players)    
    players = Create_Players.create(list_players)
        
    if req_file == 1
      Outputter.open(0,game.title,players[0].name,players[1].name)
    end
    
    Game.play(game,best_of,players[0],players[1])
    
    Outputter.close
  end
end

#Launcher.game(RPS,3,0,"AI_Usman","AI_Sam")

#Launcher.tournament(RPS,3,1,'AI_Usman','AI_Sam','AI_John','AI_Mark','AI_Joe')

Launcher.game(RPS,3,1,'AI_Usman','AI_Sam')
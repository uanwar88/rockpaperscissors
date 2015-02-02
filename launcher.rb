require 'pry'
require_relative 'game_driver.rb'
require_relative 'games.rb'  
require_relative 'player_handler.rb'
require_relative 'tournament.rb'

class Launcher
  def self.tournament(game,best_of,file,*list_players)    
    players = Create_Players.create(list_players)
    
    if file == 1
      filename = "#{game.title}_Tournament_#{rand(100)}.txt"
      Outputter.file = File.open(filename, "w")
    end
    
    Tournament.play(game,best_of,players)
    
    if Outputter.file
      Outputter.file.close
    end
  end
  
  def self.game(game,best_of,file,*list_players)    
    players = Create_Players.create(list_players)
        
    if file == 1
      filename = "#{game.title}_#{players[0].name}vs#{players[1].name}.txt"
      Outputter.file = File.open(filename, "w")
    end
    
    Game.play(game,best_of,players[0],players[1])
    
    if Outputter.file
      Outputter.file.close
    end
  end
end

#Launcher.game(RPS,3,0,"AI_Usman","AI_Sam")

#Launcher.game(RPS,3,1,'AI_Usman','AI_Sam','AI_John','AI_Mark','AI_Joe')

Launcher.game(TTT,3,0,'Usman','Sam')
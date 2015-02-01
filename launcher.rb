require 'pry'
require_relative 'game_driver.rb'
require_relative 'games.rb'  
require_relative 'player_handler.rb'
require_relative 'tournament.rb'

class Launcher
  def self.tournament(game,best_of,file,*list_players)
    players = Create_Players.create(list_players)
    Tournament.play(game,best_of,file,players)
  end
  
  def self.game(game,best_of,file,*list_players)
    players = Create_Players.create(list_players)
    Game.play(game,best_of,file,players[0],players[1])
  end
end

#Launcher.game(RPS,3,0,"AI_Usman","AI_Sam")

Launcher.tournament(RPS,3,0,'AI_Usman','AI_Sam','AI_John','AI_Mark','AI_Joe')
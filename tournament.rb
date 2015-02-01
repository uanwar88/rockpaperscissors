class Tournament
  def self.play(game,best_of,file,players)
    Outputter.put "New tournament initiated!"
    Outputter.put "Current players: "
    players.each {|x| Outputter.put x.name }
    Outputter.put ""
    while players.length > 1
      players[0].score = 0
      players[1].score = 0
      winner, loser = Game.play(game,best_of,file,players[0],players[1])
      players << winner
      players.delete_at(0)
      players.delete_at(0)
    end
    Outputter.put "#{players[0].name} wins the tournament!"
  end
end
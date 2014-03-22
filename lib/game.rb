class Game
	
	attr_reader :players, :total_kills
	
	def initialize
		@players = Hash.new
		@total_kills = 0
	end

	def addPlayer(player)
		@players [player.id] = player
	end
  
  def kill(killer, killed)
    
    @total_kills += 1
    
    if( killer == :world )
      
      killed.suicide
    else
      killer.kill
      killed.die
    end
  end
  
  def report
    
    kills ||= {}
    @players.values.map do |player|
      kills[player.nick] = player.kills
    end
    
    kills = kills.sort_by{|key, value| key }.to_h
    players = kills.keys
    
    report_game = { 'total_kills' => @total_kills,
                    'players' => players, 
                    'kills' => kills }
    
    report_game
  end

end

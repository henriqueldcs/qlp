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

end

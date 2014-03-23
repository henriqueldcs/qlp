class Game
	#require 'means_of_kill'
	#include 'MeansOfKill'
	
	attr_reader :players, :total_kills, :means
	
	MEANS_KILL = {
    0 => 'MOD_UNKNOWN',
    1 => 'MOD_SHOTGUN',
    2 => 'MOD_GAUNTLET',
    3 => 'MOD_MACHINEGUN',
    4 => 'MOD_GRENADE',
    5 => 'MOD_GRENADE_SPLASH',
    6 => 'MOD_ROCKET',
    7 => 'MOD_ROCKET_SPLASH',
    8 => 'MOD_PLASMA',
    9 => 'MOD_PLASMA_SPLASH',
    10=> 'MOD_RAILGUN',
    11=> 'MOD_LIGHTNING',
    12=> 'MOD_BFG',
    13=> 'MOD_BFG_SPLASH',
    14=> 'MOD_WATER',
    15=> 'MOD_SLIME',
    16=> 'MOD_LAVA',
    17=> 'MOD_CRUSH',
    18=> 'MOD_TELEFRAG',
    19=> 'MOD_FALLING',
    20=> 'MOD_SUICIDE',
    21=> 'MOD_TARGET_LASER',
    22=> 'MOD_TRIGGER_HURT',
    23=> 'MOD_NAIL',
    24=> 'MOD_CHAINGUN',
    25=> 'MOD_PROXIMITY_MINE',
    26=> 'MOD_KAMIKAZE',
    27=> 'MOD_JUICED',
    28=> 'MOD_GRAPPLE'
  }

	
	def initialize
		@players = Hash.new
		@means = Hash.new
		@total_kills = 0
	end

	def addPlayer(player)
		@players [player.id] = player
	end
  
  def kill(killer, killed, mean)
    
    @total_kills += 1
    @means[MEANS_KILL[mean]] ||= 0
    @means[MEANS_KILL[mean]] += 1
    
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
  
  def report_means
    report_mean = { "kill_by_means" => @means}
  end

end

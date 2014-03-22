class Game
	
	attr_reader :players
	
	def initialize
		@players = Hash.new
	end

	def addPlayer(player)
		@players [player.id] = player
	end

end

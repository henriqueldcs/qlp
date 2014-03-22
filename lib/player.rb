class Player

	attr_reader :id
	attr_accessor :nick, :kill, :die
	
	def initialize ( id, nick )
		@id = id
		@nick = nick
	end

end

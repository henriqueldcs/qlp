class Player

	attr_reader :id, :kills, :deaths
	attr_accessor :nick
	
	def initialize ( id )
		@id = id
		@kills = 0
		@deaths = 0
	end

  def kill
    @kills += 1
  end
  
  def die
    @deaths += 1
  end
  
  def suicide
    @kills -= 1
  end
end

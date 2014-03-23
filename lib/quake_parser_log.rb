class QuakeParserLog
  
  attr_reader :games, :current_game
  
  def initialize file_reader
    @file_reader = file_reader
    @games = []
  end
  
  def report
    
    report = {}
    
    @games.each_with_index do |game, index|
      report["game_#{index}"] = game.report
    end
    
    report
  end
  
  def parse
    line = @file_reader.next_line
    while line != nil
      parse_line  line
      
      line = @file_reader.next_line

    end 
  end
  
  def parse_line line
  
    instruction = get_instruction line
    ret = true
    case
      when instruction == nil
        ret = false
      when instruction[:instruction] == 'InitGame'
        new_game
      when instruction[:instruction] == 'ClientConnect'
        add_player(instruction[:id])
      when instruction[:instruction] == 'ClientUserinfoChanged'
        change_player_information instruction
      when instruction[:instruction] == 'Kill'
        kill( instruction )
    end
    
    ret
  end
  
  def get_instruction line
    instruction = {}
    
    if(line == nil)
      instruction = nil
      
    elsif( start = get_index(line, 'InitGame'))
      instruction[:instruction] = 'InitGame'        

    elsif( index = get_index(line, 'ClientConnect'))    
      instrucao = get_substring( line, index )
      id_player = get_substring( instrucao, instrucao.index(':')+1 ).to_i
      
      instruction[:instruction] = 'ClientConnect'
      instruction[:id] = id_player
    
    elsif( index = get_index(line, 'ClientUserinfoChanged'))
      instrucao = get_substring( line, index )
      id_player = get_substring( instrucao, instrucao.index(':')+1 ).to_i
      
      instrucao = get_substring(instrucao, instrucao.index('\\') + 1)
      nick_player = instrucao[0, instrucao.index('\\')]
      
      instruction[:instruction] = 'ClientUserinfoChanged'
      instruction[:id] = id_player
      instruction[:nick] = nick_player
    
    elsif( index = get_index(line, 'Kill') )  
      instrucao = get_substring( line, index )
      array = instrucao.split(' ')
      
      instruction[:instruction] = 'Kill'
      instruction[:id_killer] = array[1].to_i
      instruction[:id_killed] = array[2].to_i
      instruction[:id_weapon] = array[3].to_i
    
    end 
    
    instruction
    
  end  

  
  private
  def get_index line, index
    line.index(index) 
  end
  
  def get_substring string, start
    string[start, string.size]
  end
  
  def new_game
    @current_game = Game.new
    @games.push @current_game
  end
  
  def add_player id
    player = Player.new id
    @current_game.addPlayer player
  end
  
  def change_player_information instruction
    
    if instruction != nil \
            && instruction[:id] != nil \
            && instruction[:nick] != nil \
            && @current_game.players.has_key?(instruction[:id])
        
        player = @current_game.players[instruction[:id]]
        player.nick = instruction[:nick]
    end
  end
  
  def kill instruction
    if instruction != nil \
            && instruction[:id_killer] != nil \
            && instruction[:id_killed] != nil 
            
      if instruction[:id_killer] == 1022
        killer = :world
      else
        killer = @current_game.players[instruction[:id_killer]]
      end
    
      killed = @current_game.players[instruction[:id_killed]]
      
      @current_game.kill(killer, killed)
    end
  end
end
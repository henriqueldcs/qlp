require 'spec_helper'
require 'player'
require 'game'

describe Game do
  
  before do
  
    @game = Game.new
    @player1 = Player.new 1
    @player2 = Player.new 2

  end
  
	describe "#addPlayer" do
		it "Adiciona um jogador ao jogo" do
			
			@game.addPlayer(@player1)

			expect(@game.players.size).to eq(1)
		end

		it "Adiciona dois jogadores ao jogo" do

			@game = Game.new
			@game.addPlayer(@player1)
			@game.addPlayer(@player2)

			expect(@game.players.size).to eq(2)
		end
	end
	
	describe "#kill" do
	  it "Quando o <world> mata o player ele perde -1 kill." do
	    
	    @game.addPlayer(@player1)
	    @game.kill(:world, @player1, 22)
	    
	    expect( @player1.kills ).to eq(-1)
	  end
	
  	it "Quando um player mata um adversário seu atributo kills deve ser incrementado." do
  	  @game.addPlayer(@player1)
      @game.addPlayer(@player2)
      
      @game.kill(@player1, @player2, 22)
      
      expect( @player1.kills).to eq(1)
  	end
  	
  	it "Quando um player é morto por um adversário seu atributo deaths deve ser incrementado." do
      @game.addPlayer(@player1)
      @game.addPlayer(@player2)
      
      @game.kill(@player1, @player2, 22)
      
      expect( @player2.deaths).to eq(1)
    end
    
    it "Quando ocorre uma morte no jogo, total_kills deve ser incrementado." do
      
      @game.addPlayer(@player1)
      @game.addPlayer(@player2)
      
      @game.kill(@player1, @player2, 22)
      @game.kill(:world, @player2, 22)
      
      expect(@game.total_kills).to eq(2)
    end
	end
	
	describe "#report" do
	  it "Deve retornar um hash com o ranking do jogo." do
	    @game.addPlayer(@player1)
      @game.addPlayer(@player2)
      
      @player1.nick='Pato'
      @player2.nick='Ganso'
      
      @game.kill(@player1, @player2, 22)
      @game.kill(@player1, @player2, 22)
      @game.kill(@player1, @player2, 22)
      @game.kill(@player2, @player1, 22)
      @game.kill(@player2, @player1, 22)
      @game.kill(:world, @player2, 22)
      
      hash_esperado = {
        'total_kills' => 6,
        'players' => ['Ganso', 'Pato'],
        'kills' => {
          'Ganso' => 1,
          'Pato' => 3
        }
      }
      
      expect( @game.report).to eq hash_esperado
      
	  end
	end
	
	describe "#report_means" do 
	  it "deve retornar um hash com o ranking de meios de morte." do
	    
	    @game.addPlayer(@player1)
      @game.addPlayer(@player2)
      
      @player1.nick='Pato'
      @player2.nick='Ganso'
      
      @game.kill(@player1, @player2, 1)
      @game.kill(@player1, @player2, 1)
      @game.kill(@player1, @player2, 10)
      @game.kill(@player2, @player1, 10)
      @game.kill(@player2, @player1, 2)
	    
	    hash_esperado = {
        'kill_by_means' => {
          "MOD_SHOTGUN" => 2,
          "MOD_RAILGUN" => 2,
          "MOD_GAUNTLET"=> 1
        }
      }
      
      expect( @game.report_means).to eq(hash_esperado)
	  end
	end
end

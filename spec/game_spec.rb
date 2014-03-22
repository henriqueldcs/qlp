require 'spec_helper'
require 'player'
require 'game'

describe Game do
	describe "#addPlayer" do
		it "Adiciona um jogador ao jogo" do
			player = Player.new 1
			game = Game.new
			game.addPlayer(player)

			expect(game.players.size).to eq(1)
		end

		it "Adiciona dois jogadores ao jogo" do
			player1 = Player.new 1
			player2 = Player.new 2
			game = Game.new
			game.addPlayer(player1)
			game.addPlayer(player2)

			expect(game.players.size).to eq(2)
		end
	end
	
end

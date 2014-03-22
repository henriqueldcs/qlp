require 'spec_helper'
require 'player'

describe Player do
  
  before do 
    @player = Player.new 1
  end
	
	describe "#kill" do
	  it 'jogador mata adversário' do
	    @player.kill
	    expect(@player.kills).to eq 1
	  end
	  
	  it 'jogador mata dois adversários' do
	    @player.kill
	    @player.kill
	    expect(@player.kills).to eq 2
	  end
	end
	
	describe "#die" do
	  it 'jogador morre' do
	    @player.die
	    expect(@player.deaths).to eq 1
	  end
	  
	  it 'jogador morre duas vezes' do
      @player.die
      @player.die
      expect(@player.deaths).to eq 2	    
	  end
	end
	
	describe "#suicide" do
	  it 'jogador pode cometer suicidio' do
	    @player.suicide
	    expect(@player.kills).to eq(-1)
	  end
	end
	
end

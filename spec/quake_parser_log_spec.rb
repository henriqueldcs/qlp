require 'spec_helper'
require 'quake_parser_log'

describe QuakeParserLog do
  describe '#get_instruction' do
    
    before do
      @file_reader = FileReader.new nil
      @parser = QuakeParserLog.new @file_reader
    end
    
    it "deve 'parsear' a instrução 'InitGame' " do
      line = '  0:00 InitGame: \sv_floodProtect\1\sv_maxPing\0\sv_minPing\0\sv_maxRate\10000\sv_minRate\0\sv_hostname\Code Miner Server\g_gametype\0\sv_privateClients\2\sv_maxclients\16\sv_allowDownload\0\dmflags\0\fraglimit\20\timelimit\15\g_maxGameClients\0\capturelimit\8\version\ioq3 1.36 linux-x86_64 Apr 12 2009\protocol\68\mapname\q3dm17\gamename\baseq3\g_needpass\0\n' 
      instruction = @parser.get_instruction line
      
      expected = {:instruction => 'InitGame'}
      
      expect( instruction ).to eq(expected)      
    end
    
    it "deve 'parsear' a instrução 'ClientConnect'" do
      line = '20:34 ClientConnect: 2'
      instruction = @parser.get_instruction line
      
      expected = {:instruction => 'ClientConnect',
                  :id => 2}
      
      expect(instruction).to eq(expected)
    end

    it "deve 'parsear' a instrução 'ClientUserinfoChanged'" do
      line = ' 20:34 ClientUserinfoChanged: 2 n\Isgalamido\t\0\model\xian/default\hmodel\xian/default\g_redteam\\g_blueteam\\c1\4\c2\5\hc\100\w\0\l\0\tt\0\tl\0'
      instruction = @parser.get_instruction line
      
      expected = {:instruction => 'ClientUserinfoChanged',
                  :id => 2,
                  :nick => 'Isgalamido'}
      
      expect(instruction).to eq(expected)
    end

    it "deve 'parsear' a instrução 'Kill'" do
      line = '  1:26 Kill: 1022 4 22: <world> killed Zeh by MOD_TRIGGER_HURT'
      instruction = @parser.get_instruction line
      
      expected = {:instruction => 'Kill',
                  :id_killer => 1022,
                  :id_killed => 4,
                  :id_mean => 22}
      
      expect(instruction).to eq(expected)
    end
    
  end  
end

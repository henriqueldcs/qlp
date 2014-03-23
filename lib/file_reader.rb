class FileReader
  
  def initialize file_name
    @file = File.open(file_name, 'r') unless file_name == nil
  end
  
  def next_line
    
    if !@file.eof?
      @file.readline
    else
      nil
    end
  end
  
  
end
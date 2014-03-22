class FileReader
  
  def initialize file_name
    
    @file = File.open(file_name, 'r')
  end
  
  def next_line
    @file.readline
  end
  
  
end
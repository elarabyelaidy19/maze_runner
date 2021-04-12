module MazeClasses 

  class Maze  
    DELTAS = [[1, 0], [0, 1], [-1, 0], [0, -1]] 

    attr_reader :start_inedx, :end_inedx 

    def initialize(filename) 
      @map = load_map(filename) 

    end 

    def load_map(filename) 
      maze = [] 
      File.open(filename).each_line do |line| 
        chars = line.split(//) 
        



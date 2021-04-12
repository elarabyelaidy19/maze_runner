module MazeClasses 

  class Maze  
    DELTAS = [[1, 0], [0, 1], [-1, 0], [0, -1]] 

    attr_reader :start_inedx, :end_inedx 

    def initialize(filename) 
      @map = load_map(filename) 
      @title = parse_title(filename) 

    end 

    def load_map(filename) 
      maze = [] 
      File.open(filename).each_line do |line| 
        chars = line.split(//) 
        maze << chars
      end 
      maze 
    end 

    def is_wall?(point) 
      x, y = point 
      @map[y][x] == "*" 
    end 

    def in_maze?(point) 
      x, y = point 
      not_negative = (x >= 0) && (y >= 0) 
      within_bounds = (x <= @map[0].length) && (y <= @map.length) 
      not_negative && within_bounds 
    end 

    def parse_title(filename) 
      filename.match(/(.+)\.txt/)[1] 
    end 

    def to_s 
      string = "MAZE: #{@title}\n" 
      @map.each do |line| 
        string << line.join("") 
      end 
      string  
    end 

    def find_char(char) 
      @map.each_with_index do |line, y| 
        return [line.index(char), y] if line.index(char) 
      end 
    end 

    def find_start 
      find_char("S") 
    end 

    def find_end
      find_char("E") 
    end 
    





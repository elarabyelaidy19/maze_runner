module MazeClasses 

  class Maze  
    DELTAS = [[1, 0], [0, 1], [-1, 0], [0, -1]] 

    attr_reader :start_inedx, :end_inedx 

    def initialize(filename) 
      @map = load_map(filename) 
      @title = parse_title(filename) 
      @start_inedx = find_start 
      @end_inedx = find_end 
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

    def find_neighbors(point) 
      p_x, p_y = point 
      neighbors = [] 
      DELTAS.each do |d_x, d_y| 
        neighbor = [(d_x + p_x), (d_y + p_y)] 
        if in_maze?(neighbor) && !is_wall?(neighbor) 
          neighbors << neighbor 
        end 
      end 
      neighbors 
    end 

    def travel_path(path) 
      puts "travelling path of #{path.inspect}.." 
      copy_map = deep_dup(@map) 
      path.each do |coords| 
        x, y  = coords 
        point = copy_map[y][x] 
        if point == "X" 
          puts "This path back-tracks to #{x}, #{y}." 
        elsif point == "*" 
          puts "this path hits a wall at #{x}, #{y}." 
        else  
          copy_map[y][x] = "X" 
        end 
      end 
      show_path(copy_map) 
    end  

    end 

    def show_path(map) 
      map.each do |line|
        puts line.join("") 
      end 
    end 

    private 

    def deep_dup(item) 
      unless item.class == Array 
        item.dup 
      else  
        new_arr = [] 
        item.each do |item| 
          new_arr << deep_dup(item) 
        end 
        new_arr 
      end 
    end 
  end 

  class Maze_Solver 

    def initialize(maze) 
      @maze = maze 
    end 

    # find the overall distance from start to end 
    def find_distance(point) 
      p_x, p_y = point 
      final_x, final_y = @maze.find_end
      ((p_x - final_x) + (p_y - final_y)).abs
    end 

    def find_manhattan_estimate(point) 
      dist_to_end = find_distance(point) 
      dist_traveled = find_path(point).length
      f = dist_to_end + dist_traveled 
    end 

    

    def find_path(goal = @maze.find_end) 
      path = [goal]
      spot = goal 
      until @branching_paths[spot] == nil 
        path << @branching_paths[spot] 
        spot = @branching_paths[spot]
      end
      path 
     end 

    private 
    def reset_values 
      @branching_paths = {} 
      @current = @maze.find_start
    end 
 
 

 






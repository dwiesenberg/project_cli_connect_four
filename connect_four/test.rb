
class Board

  attr_accessor :available_positions

    attr_accessor :col, :row, :color
    attr_accessor :available_positions 
    COLUMN_PRIORITY = [3, 2, 4, 1, 5, 0, 6]
    COLORS = ["R", "Y"] 

    def initialize
      @frame = [[" ", "R", "Y"], [" ", " ", "Y"], [" ", " ", "Y"]]
      @available_positions = [0, 1, 3] 
    end  

    def tasks
      update_frame
      update_available_positions

    def update_frame(col = 1, color = "Y")
      @col = col
      @row = @available_positions[@col]
      @frame[@row][@col] = color
      puts " in update_frame ... updated frame"

    end

    def update_available_positions(col)
      @col = col
      @available_positions[@col] += 1 
        # if column is full then value (row) incremented to 6
    end 


end

class Board_AI < Board

  def initialize

  end

  def round 
    COLORS.each do |color|
      COLUMN_PRIORITY do |col|
        next if @available_positions[@col] > 5 # column full
        @col = col
        @row = @available_positions[@col]
        @frame[@row][@col] = color
      end
    end
    false
  end


end

Board.new
Board.update_frame






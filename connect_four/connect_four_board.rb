# Connect Four

# class Board

module ConnectFour
  class Board

    attr_accessor :col, :row, :color
    attr_accessor :available_positions 
    COLUMN_PRIORITY = [3, 2, 4, 1, 5, 0, 6]
    COLORS = ["R", "Y"]


    def initialize
      @frame = Array.new(6){Array.new(7, " ")} # 6 rows, 7 columns
      @available_positions = Array.new(7, 0) 
      puts "in class Board ... initialized ..."
      puts "@available_positions = #{@available_positions}"
        # 7 columns, value = available row, starting from botto
    end  

    def test_Board
      puts "test_Board"
    end

    def update_frame(col, color)
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

    def render_frame 
      puts "\nCURRENT BOARD"
      puts   "-------------"
      
      puts " --- --- --- --- --- --- --- "
      @frame.reverse.each do |row|
        row.each do |cell|
          print "| #{cell} "
        end
        puts "|"
        puts " --- --- --- --- --- --- --- "
      end
    end

    def available_positions?   # col is full if row > 5
      @available_positions.each { |row| return true unless row > 5  }
      false
    end

   # Search for line of four consecutive counters. Start from the position of the latest counter. Search in all available direct-ions. If another 3 eligible counters are of the same color, then there is a "line of four". 

    def line_of_four?
      result = vert_d? || horiz_lr? || diag_bltr? || diag_brtl?
        # see meanings of abreviations in methods below
    end

    def vert_d? # vertically down
      @consecutive_counters = 1 
      return false if @row < 3 # edge condition
      3.times do |num|
        return false if @frame[@row - (num + 1)][@col] \
                     != @frame[@row][@col]
        return true if consecutive_counters_match
      end
      false
    end

    def horiz_lr? # horizontally left and right
      @consecutive_counters = 1 
      return true if horiz_l? # horizontally left
      return true if horiz_r? # horizontally right
      false
    end

    def horiz_l? # horizontally left
      3.times do |num|
        return false if @col - (num + 1) < 0 # edge condition
        if @frame[@row][@col - (num + 1)] ==  @frame[@row][@col]
          return true if consecutive_counters_match
        else
          return false
        end
      end
      false
    end

    def horiz_r? # horizontally right
      3.times do |num|
        return false if @col + (num + 1) > 6 # edge condition
        if @frame[@row][@col + (num + 1)] ==  @frame[@row][@col]
          return true if consecutive_counters_match
        else
          return false
        end
      end
      false
    end

    def diag_bltr? # diagonally bottom left to top right
      @consecutive_counters = 1 
      return true if diag_bl? # diagonally bottom left
      return true if diag_tr? # diagonally top right
      false
    end

    def diag_bl? # diagonally bottom left
      3.times do |num|
        return false if @row - (num + 1) < 0 || @col - (num + 1) < 0
           # edge condition
        if @frame[@row - (num + 1)][@col - (num + 1)] ==  @frame[@row][@col]
          return true if consecutive_counters_match
        else
          return false
        end
      end
      false
    end

    def diag_tr? # diagonally top right
      3.times do |num|
        return false if @row + (num + 1) > 5 || @col + (num + 1) > 6
           # edge condition
        if @frame[@row + (num + 1)][@col + (num + 1)] ==  @frame[@row][@col]
          return true if consecutive_counters_match
        else
          return false
        end
      end
      false
    end

    def diag_brtl? # diagonally bottom right to top left
      @consecutive_counters = 1 
      return true if diag_br? # diagonally bottom right
      return true if diag_tl? # diagonally top left
      false
    end

    def diag_br? # diagonally bottom left
      3.times do |num|
        return false if @row - (num + 1) < 0 || @col + (num + 1) > 6
           # edge condition
        if @frame[@row - (num + 1)][@col + (num + 1)] ==  @frame[@row][@col]
          return true if consecutive_counters_match
        else
          return false
        end
      end
      false
    end

    def diag_tl? # diagonally top right
      3.times do |num|
        return false if @row + (num + 1) > 5 || @col - (num + 1) < 0
           # edge condition
        if @frame[@row + (num + 1)][@col - (num + 1)] ==  @frame[@row][@col]
          return true if consecutive_counters_match
        else
          return false
        end
      end
      false
    end

    def consecutive_counters_match
      @consecutive_counters += 1
      return true if @consecutive_counters == 4
      false
    end  

    # End - Search for line of four consecutive counters

  end # class Board

end # Module ConnectFour





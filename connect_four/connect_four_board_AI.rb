# Connect Four

# class Board_AI

module ConnectFour
  class Board_AI < Board


    def initialize
      puts "Board_AI initializing ... " 
      puts "@available_positions = #{@available_positions}"
    end

    def test_AI
      puts "test_AI works ..."
    end


################################

#    def decide_move(available_positions, board)
    def decide_move
#      @available_positions = available_positions
#      @board = board
      @win_by_AI = "N"
      possible_placement_win? || possible_line?(:line_of_three?) || possible_line?(:line_of_two?) || first_available_column
      @col
    end

################################
   

    def possible_placement_win?

      COLORS.each do |color|

        puts "@available_positions[1] = #{@board.available_positions[1]}"
        COLUMN_PRIORITY.each do |col|
          next if @available_positions[col] > 5 # column full
          @color = color
          @col = col
          @row = @available_positions[@col]
          p "@frame = #{@frame}"
          @frame[@row][@col] = @color
          if @color == "R" && line_of_four?   # in class Board
            @win_by_AI = "Y"
            return @col
          end
          @frame[@row][@col] = " "
        end
      end
      false
    end

###################################

    def possible_line?(number_of_counters) 
      COLORS.each do |color|
        COLUMN_PRIORITY do |col|
          next if @available_positions[@col] > 5 # column full
          @col = col
          @row = @available_positions[@col]
          @frame[@row][@col] = color
          return @col if send(number_of_counters) 
            # line_of_three or line_of_two
          @frame[@row][@col] = " "
        end
      end
      false
    end


###################################

    # Search for line of three consecutive counters. Start from the position of the latest counter. Search in all available direct-ions. If another 2 eligible counters are of the same color, then there is a "line of three". Note: these methods overwrite the identical ones in class Board

    def line_of_three?
        puts "in line-of-thre ... ? "
        result = vert_d? || horiz_lr? || diag_bltr? || diag_brtl?
          # see meanings of abreviations in methods below
    end

    def vert_d? # vertically down
      @consecutive_counters = 1 
      return false if @row < 3 # edge condition
      2.times do |num|
        return false if @frame[@row - (num + 1)][@col] \
                     != @frame[@row][@col]
        return true if consecutive_counters_match 
          # Note. Space above available position will always be free so no need to check for potential fourth space.
      end
      false
    end

    def horiz_lr? # horizontally left and right
      @consecutive_counters = 1 
      @potential_fourth_space = "N"
      return true if horiz_l? # horizontally left
      return true if horiz_r? # horizontally right
      false
    end

    def horiz_l? # horizontally left
      2.times do |num|
        return false if @col - (num + 1) < 0 # edge condition
        if @frame[@row][@col - (num + 1)] ==  @frame[@row][@col]
          if consecutive_counters_match
            return true if @frame[@row][@col - (num + 2)] == " " 
          else
            @potential_fourth_space = "Y" if @frame[@row][@col - (num + 2)] == " "  
          end
        end
      end
      false
    end

    def horiz_r? # horizontally right
      2.times do |num|
        return false if @col + (num + 1) > 6 # edge condition
        if @frame[@row][@col + (num + 1)] ==  @frame[@row][@col]     then if consecutive_counters_match
            then if @frame[@row][@col + (num + 2)] == " " ||  @potential_fourth_space == "Y"
              return true 
            end
          end   
        end
      end
      false
    end

    def diag_bltr? # diagonally bottom left to top right
      @consecutive_counters = 1  
      @potential_fourth_space = "N"
      return true if diag_bl? # diagonally bottom left
      return true if diag_tr? # diagonally top right
      false
    end

    def diag_bl? # diagonally bottom left
      2.times do |num|
        return false if @row - (num + 1) < 0 || @col - (num + 1) < 0
           # edge condition
        if @frame[@row - (num + 1)][@col - (num + 1)] ==  @frame[@row][@col]
          if consecutive_counters_match
            return true if @frame[@row - (num + 2)][@col - (num + 2)] == " " 
          else
            @potential_fourth_space = "Y" if @frame[@row - (num + 2)][@col - (num + 2)] == " "  
          end
        end
      end
      false
    end

    def diag_tr? # diagonally top right
      2.times do |num|
        return false if @row + (num + 1) > 5 || @col + (num + 1) > 6
           # edge condition
        if @frame[@row + (num + 1)][@col + (num + 1)] ==  @frame[@row][@col]    
          if consecutive_counters_match
            return true if @frame[@row + (num + 2)][@col + (num + 2)] == " " || @potential_fourth_space == "Y"
          end   
        end
      end
      false
    end

    def diag_brtl? # diagonally bottom right to top left
      @consecutive_counters = 1  
      @potential_fourth_space = "N"
      return true if diag_br? # diagonally bottom right
      return true if diag_tl? # diagonally top left
      false
    end

    def diag_br? # diagonally bottom left
      2.times do |num|
        return false if @row - (num + 1) < 0 || @col + (num + 1) > 6
           # edge condition
        if @frame[@row - (num + 1)][@col + (num + 1)] ==  @frame[@row][@col]
          if consecutive_counters_match
            return true if @frame[@row - (num + 2)][@col + (num + 2)] == " "
          else
            @potential_fourth_space = "Y" if @frame[@row - (num + 2)][@col + (num + 2)] == " "
          end
        end
      end
      false
    end

    def diag_tl? # diagonally top right
      2.times do |num|
        return false if @row + (num + 1) > 5 || @col - (num + 1) < 0
           # edge condition
        if @frame[@row + (num + 1)][@col - (num + 1)] ==  @frame[@row][@col]    
          if consecutive_counters_match
            return true if @frame[@row + (num + 2)][@col - (num + 2)] == " " || @potential_fourth_space == "Y"
          end   
        end
      end
      false
    end

    def consecutive_counters_match
      @consecutive_counters += 1
      return true if @consecutive_counters == 3
      false
    end

    # End - Search for line of three consecutive counters

    # Search for line of two consecutive counters. Start from the position of the latest counter. Search in all available directions.If an adjacent counter is of the same color, then there is a "line of two".

    def line_of_two? # look for adjacent counter of same color    
      puts "in line-of-two? "
        case @frame[@row][@col]                
        when @frame[@row - (num + 1)][@col], # vertically down \
             @frame[@row][@col - (num + 1)], # horizontally left \
             @frame[@row][@col + (num + 1)], # horizontally right \
             @frame[@row - (num + 1)][@col - (num + 1)],
               # diagonally bottom left \            
             @frame[@row + (num + 1)][@col + (num + 1)],
               # diagonally top right \           
             @frame[@row - (num + 1)][@col + (num + 1)],
               # diagonally bottom right \     
             @frame[@row + (num + 1)][@col - (num + 1)] 
               # diagonally top left            
          return true
        end
      false
    end

    def first_available_column
      COLORS.each do |color|
        COLUMN_PRIORITY do |col|
          next if @available_positions[col] > 5 # column full
          @col = col
          @row = @available_positions[@col]
          @frame[@row][@col] = color
          return @col # return value
        end
      end
    end



    # End - Search for line of two consecutive counters

  end # end of class Board_AI

end # end of module ConnectFour
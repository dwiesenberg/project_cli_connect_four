# Connect Four

# class Game

module ConnectFour
  class Game
    def initialize
      @board = Board.new
      Player.new
    end

    def play
      welcome
      setup_players
      @current_player = choose_beginner
      take_turn # loop method
      # note. no further code since loop exits on
      #    1. win 2. draw 3. interrupt
    end

    def take_turn
      loop do
        @board.available_positions? || draw 
          # to place counter in; game draw if none
        @current_player.make_move
        @board.render_board
        win?
        @current_player = change_players
        pause # to consider move or interrupt game
      end
    end


    def welcome
      puts %{ 

        Welcome to Connect Four! Are you a champion?

        INTRODUCTION
        ------------
        Connect Four is an absorbing and challenging game of 
        vertical strategy that’s easy to learn and fun to play. 
        Rules are simple. Each player tries to build a row of four 
        counters in the board (frame) - horizontally, vertically, or 
        diagonally - while trying to prevent his opponent from doing 
        the same.

        The board is 6 rows deep and 7 columns accross and looks 
        like this:
         --- --- --- --- --- --- --- 
        | o | o | o | o | o | o | o |
         --- --- --- --- --- --- --- 
        | o | o | o | o | o | o | o |
         --- --- --- --- --- --- --- 
        | o | o | o | o | o | o | o |
         --- --- --- --- --- --- --- 
        | o | o | o | o | o | o | o |
         --- --- --- --- --- --- --- 
        | o | o | o | o | o | o | o |
         --- --- --- --- --- --- --- 
        | o | o | o | o | o | o | o |
         --- --- --- --- --- --- --- 
         
        OBJECT OF THE GAME
        ------------------ 
        Be the first player to get four of your counters in a row - 
        horizontally, vertically or diagonally.

        RULES
        -----
        1. Choose who plays first. 
        2. The first and second players have yellow and red counters 
           respectively.
        3. Each player in his turn drops one of his counters down 
           any of the slots in the top of the grid.
        4. The play alternates until one of the players gets four 
           counters of his colour in a row. The four in a row can be 
           horizontal, vertical, or diagonal.
        5. The first player to get four in a row wins.
        6. If the board is filled with pieces and neither player has 
           four in a row, then the game is a draw.

      }
    end

    def setup_players # note: Y, R = yellow, red counters
      @player_1 = Human.new(@board, get_player_name, "Y")  
        # Y = yellow counters
      if play_computer? == "Y"
        @player_2 = Computer.new(@board, "the Computer", "R")
          # R = red counters
      else
        @player_2 = Human.new(@board, get_player_name, "R")
      end
    end
  
    def get_player_name
      print "What is your name? "
      while "" == (name = gets.chomp)
        print "You didn't enter an answer. Try again: "
      end
      name
    end

    def play_computer?
      print "Do you want to play against the computer? (Y/N): "
      until %w(Y N).include? (answer = gets.chomp.upcase)
        print "Incorrect entry. Try again: "
      end
      print "Opponent: " if answer == "N"
      answer
    end

    def choose_beginner
      print "Who should begin? Enter M (for 'Me') or O (for 'Opponent'): "
      until %w(M O).include? (answer = gets.chomp.upcase)
        print "Incorrect entry -- try again (M or O): "
      end
      answer == "M" ? @player_1 : @player_2
    end

    def pause
      print "Hand over to #{@current_player}. Press RETURN when ready or Q (to quit game early): "
      until ["", "Q"].include? (answer = gets.chomp.upcase)
        print "Incorrect entry - try again: "
      end
      return if answer.empty? # on to next move
      print "\nSorry to see you go. Come back soon!\n\n" # answer = "Q"
      exit
    end

    def win?
      # win if four consecutive counters are found
      return unless @board.line_of_four?
      puts "\nCongratulations! #{@current_player.to_s} has won the game\n"
      exit
    end

    def draw
      # no more available positions
      puts "\nThis game is a draw. Goodbye!\n"
      exit
    end

    def change_players
      @current_player == @player_1 ? @player_2 : @player_1 
        # note: @current_player = player_1 OR @player_2 only
    end


  end
end











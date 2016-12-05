# Connect Four

# class Computer

module ConnectFour
  class Computer < Player
    attr_accessor :board, :name, :color 

    def initialize(board, name, color)  
      @board = board
      @name = name
      @color = color
      @board_AI = Board_AI.new       
    end

# story 1 - random move - superseded by story 2 (AI move)
#    def make_move
#      print "Computer to play ... "
#      sleep(1)
#      while @board.available_positions[@col = rand(0..6)] > 5; end
#      puts "counter dropped into column #{@col}"
#      @board.update_frame(@col, @color)
#    end

# story 2 - AI move

#    def make_move(available_positions, board)
    def make_move     
      print "Computer to play ... "
      sleep(1)
#      @board_AI.decide_move(available_positions, board)
      @board_AI.decide_move
      @col
    end

  end
end


      
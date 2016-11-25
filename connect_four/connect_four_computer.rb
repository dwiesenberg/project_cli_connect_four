# Connect Four

# class Computer

module ConnectFour
  class Computer < Player
    attr_accessor :board, :name, :color 

    def initialize(board, name, color)
# TODO     super      Q: 1. super necessary anyway? 2. why is there argument problem (like 2 for 1) - does not reconcile 1 arg for super (board) and one for Human (name)     
      @board = board
      @name = name
      @color = color
    end

    def to_s
      @name
    end

    def make_move
      print print "Computer to play ... "
      sleep(1)
      while @board.available_positions[@col = rand(0..6)] > 5; end
      puts "counter dropped into column #{@col}"
      @board.update_board(@col, @color)
    end

  end
end


      
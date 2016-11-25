# Connect Four

# class Human

module ConnectFour
  class Human < Player
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
      print %{
        Make your move. Which column (1-7 from the left) are you
        dropping your counter into? }
      loop do
        until (1..7).include? (@col = gets.chomp.to_i)
          print "Incorrect entry. Try again: "
        end
        break unless @board.available_positions[@col - 1] > 5
        print "Column already filled. Choose another: "
      end
      @board.update_board(@col - 1, @color)
    end

  end
end
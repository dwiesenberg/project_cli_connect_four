
class Game

  attr_accessor :board

  def initialize
    @Board = Board.new
    puts "in Game ... @board = #{@board.object_id}"
    printout
    @player_2 = Computer.new(board)
  end

  def printout   
    puts "@board.frame = #{@board.frame}"
    puts "@board.available_positions = #{@board.available_positions}"
  end

end

class Board

  attr_accessor :frame, :available_positions

  def initialize
    puts "in Board ... @board = #{@board.object_id}"
    @frame = [[1, 2],[3, 4] ]
    puts "frame = #{frame}"
    @available_positions = [1, 4, 3]
    puts "available_positions = #{available_positions}"
  end

  def frame
    @frame
  end

end

class Computer

  def initialize(board)
    @board = board

    puts "in Computer ... @board = #{@board.object_id}"
    @board_AI = Board_AI.new(board)
    puts "in Computer ... @board_AI = #{@board_AI}"
  end

end

class Board_AI

  def initialize(board)
    @board = board

    puts "in access ... @board = #{@board.object_id}"
    puts "@board.frame = #{@board.frame}"
    puts "@board.available_positions = #{@board.available_positions}"
  end

end


Game.new





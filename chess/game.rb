require_relative 'board'
require_relative 'piece'
require_relative 'display'

class Chess
  attr_accessor :board
  attr_reader :display

  def initialize
    @board = Board.new
  end

  def self.setup_board
    game = self.new
    game.board[[0, 0]] = Rook.new(game.board, [0, 0], :black)
    game
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Chess.setup_board
  display = Display.new(game.board)
  display.render
  sleep(3)
  game.board.move([0,0], [0,1])
  display.render
end

require_relative 'piece'

class King < SteppingPiece
  KING_DELTAS = [-1, 0, 1].product([-1, 0, 1]) - [[0, 0]]

  attr_reader :deltas

  def initialize(board, pos, color)
    king_mark = (color == :white ? "\u2654" : "\u265A")
    super(board, pos, color, king_mark)
    @deltas = KING_DELTAS
  end
end

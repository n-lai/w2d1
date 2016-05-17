require_relative 'piece'

class King < SteppingPiece
  KING_DELTAS = [-1, 0, 1].product([-1, 0, 1]) - [[0, 0]]
  KING_MARK = :K

  attr_reader :deltas

  def initialize(board, pos, color)
    super(board, pos, color, KING_MARK)
    @deltas = KING_DELTAS
  end
end

require_relative  'piece'

class Knight < SteppingPiece
  KNIGHT_DELTAS = [-2, -1, 1, 2].product([-2, -1, 1, 2]).reject { |a, b| a.abs + b.abs != 3 }
  KNIGHT_MARK = :H

  attr_reader :deltas

  def initialize(board, pos, color)
    super(board, pos, color, KNIGHT_MARK)
    @deltas = KNIGHT_DELTAS
  end
end

require_relative 'piece'

class Rook < SlidingPiece

  ROOK_DELTAS = RANGE.map { |elt| [0, elt] } +
                RANGE.map { |elt| [elt, 0] } +
                NEGATIVE_RANGE.map { |elt| [0, elt] } +
                NEGATIVE_RANGE.map { |elt| [elt, 0] }

  ROOK_MARK = :R

  attr_reader :deltas

  def initialize(board, pos, color)
    super(board, pos, color, ROOK_MARK)
    @deltas = ROOK_DELTAS
  end

end

require_relative 'piece'

class Rook < SlidingPiece

  ROOK_DELTAS = RANGE.map { |elt| [0, elt] } +
                RANGE.map { |elt| [elt, 0] } +
                NEGATIVE_RANGE.map { |elt| [0, elt] } +
                NEGATIVE_RANGE.map { |elt| [elt, 0] }

  attr_reader :deltas

  def initialize(board, pos, color)
    rook_mark = (color == :white ? "\u2656" : "\u265C")
    super(board, pos, color, rook_mark)
    @deltas = ROOK_DELTAS
  end

end

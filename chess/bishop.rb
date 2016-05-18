require_relative 'piece'

class Bishop < SlidingPiece

  BISHOP_DELTAS = RANGE.zip(RANGE) +
                  RANGE.zip(NEGATIVE_RANGE) +
                  NEGATIVE_RANGE.zip(NEGATIVE_RANGE) +
                  NEGATIVE_RANGE.zip(RANGE)

  attr_reader :deltas

  def initialize(board, pos, color)
    bishop_mark = (color == :white ? "\u2657" : "\u265D")
    super(board, pos, color, bishop_mark)
    @deltas = BISHOP_DELTAS
  end

  def moves
    super.reject { |x, y| (position.first - x != position.last - y) }
  end

end

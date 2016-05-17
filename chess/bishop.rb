require_relative 'piece'

class Bishop < SlidingPiece

  BISHOP_DELTAS = RANGE.zip(RANGE) +
                  RANGE.zip(NEGATIVE_RANGE) +
                  NEGATIVE_RANGE.zip(NEGATIVE_RANGE) +
                  NEGATIVE_RANGE.zip(RANGE)

  BISHOP_MARK = :B

  attr_reader :deltas

  def initialize(board, pos, color)
    super(board, pos, color, BISHOP_MARK)
    @deltas = BISHOP_DELTAS
  end

  def moves
    super.reject { |x, y| (position.first - x != position.last - y) }
  end

end

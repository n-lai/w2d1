require_relative 'piece'

class Queen < SlidingPiece

  QUEEN_DELTAS = RANGE.map { |elt| [0, elt] } +
                 RANGE.zip(RANGE) +
                 RANGE.map { |elt| [elt, 0] } +
                 RANGE.zip(NEGATIVE_RANGE) +
                 NEGATIVE_RANGE.map { |elt| [0, elt] } +
                 NEGATIVE_RANGE.zip(NEGATIVE_RANGE) +
                 NEGATIVE_RANGE.map { |elt| [elt, 0] } +
                 NEGATIVE_RANGE.zip(RANGE)

  QUEEN_MARK = :Q

  attr_reader :deltas

  def initialize(board, pos, color)
    super(board, pos, color, QUEEN_MARK)
    @deltas = QUEEN_DELTAS
  end

  def moves
    super.select do |x, y|
      (position.first - x).abs == (position.last - y).abs ||
      position.first == x ||
      position.last == y 
    end
  end

end

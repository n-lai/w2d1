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

  attr_reader :deltas

  def initialize(board, pos, color)
    queen_mark = (color == :white ? "\u2655" : "\u265B")
    super(board, pos, color, queen_mark)
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

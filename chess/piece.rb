require 'singleton'

class Piece
  attr_reader :board, :color, :mark
  attr_accessor :position

  def initialize(board, position, color, mark)
    @board = board
    @position = position
    @color = color
    @mark = " #{mark} "
  end

  def can_move?(end_pos)
    true
  end

  def to_s
    mark.to_s
  end
end

class SlidingPiece < Piece
  RANGE = (1..8).to_a
  NEGATIVE_RANGE = RANGE.map { |elt| -elt }.reverse

  def initialize(board, pos, color, mark)
    super
  end

  def moves(start)
    x, y = start
    deltas.map { |dx, dy| [x + dx, y + dy] }.select do |new_x, new_y|
      x_arr = (x...new_x).to_a.drop(1)
      y_arr = (y...new_y).to_a.drop(1)

      path = x_arr.zip(y_arr)
      board[[new_x, new_y]].color != self.color && path.all? do |space|
        board[space].is_a?(NullPiece) && board.in_bounds?(space)
      end
    end
  end
end

class SteppingPiece < Piece
  def moves(start)
    x, y = start
    @deltas.map { |dx, dy| [x + dx, y + dy] }.select do |space|
      board.in_bounds?(space) && board[space].color != self.color
    end
  end
end

class NullPiece
  include Singleton

  def to_s
    "   "
  end
end

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

  def initialize
    @deltas = QUEEN_DELTAS
  end
end

class Rook < SlidingPiece

  ROOK_DELTAS = RANGE.map { |elt| [0, elt] } +
                RANGE.map { |elt| [elt, 0] } +
                NEGATIVE_RANGE.map { |elt| [0, elt] } +
                NEGATIVE_RANGE.map { |elt| [elt, 0] }

  ROOK_MARK = :R


  def initialize(board, pos, color)
    super(board, pos, color, ROOK_MARK)
  end

end

class Bishop < SlidingPiece

  BISHOP_DELTAS = RANGE.zip(RANGE) +
                  RANGE.zip(NEGATIVE_RANGE) +
                  NEGATIVE_RANGE.zip(NEGATIVE_RANGE) +
                  NEGATIVE_RANGE.zip(RANGE)



end

class King < SteppingPiece
  KING_DELTAS = [-1, 0, 1].product([-1, 0, 1]) - [[0, 0]]
end

class Knight < SteppingPiece
  KNIGHT_DELTAS = [-2, -1, 1, 2].product([-2, -1, 1, 2]).reject { |a, b| a.abs + b.abs != 3 }
end

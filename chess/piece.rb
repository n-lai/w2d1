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

  def can_access?(end_pos)
    #fix this
    true
  end

  def move(end_pos)
    raise unless self.moves.include?(end_pos)
    board.move(self.position, end_pos)
  end

  def to_s
    #to picture
    mark.to_s
  end
end

class SlidingPiece < Piece
  RANGE = (1..8).to_a
  NEGATIVE_RANGE = RANGE.map { |elt| -elt }.reverse

  def initialize(board, pos, color, mark)
    super
  end

  def moves
    x, y = self.position
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
  def moves
    x, y = self.position
    deltas.map { |dx, dy| [x + dx, y + dy] }.select do |space|
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

  QUEEN_MARK = :Q

  attr_reader :deltas

  def initialize(board, pos, color)
    super(board, pos, color, QUEEN_MARK)
    @deltas = QUEEN_DELTAS
  end
end

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

end

class King < SteppingPiece
  KING_DELTAS = [-1, 0, 1].product([-1, 0, 1]) - [[0, 0]]
  KING_MARK = :K

  attr_reader :deltas

  def initialize(board, pos, color)
    super(board, pos, color, KING_MARK)
    @deltas = KING_DELTAS
  end
end

class Knight < SteppingPiece
  KNIGHT_DELTAS = [-2, -1, 1, 2].product([-2, -1, 1, 2]).reject { |a, b| a.abs + b.abs != 3 }
  KNIGHT_MARK = :H

  attr_reader :deltas

  def initialize(board, pos, color)
    super(board, pos, color, KNIGHT_MARK)
    @deltas = KNIGHT_DELTAS
  end
end

class Pawn < Piece
  PAWN_MARK = :P

  attr_reader :deltas

  def initialize(board, pos, color)
    super(board, pos, color, PAWN_MARK)
  end

  def moves
    moves = []
    x, y = self.position

    if board[[x + 1, y]].is_a?(NullPiece)
      moves << [x + 1, y]
      if board[[x + 2, y]].is_a?(NullPiece) && (x == 1 || x == 6)
        moves << [x + 2, y]
      end
    end

    unless board[[x + 1, y - 1]].is_a?(NullPiece)
      moves << [x - 1, y + 1]
    end

    unless board[[x + 1, y + 1]].is_a?(NullPiece)
      moves << [x + 1, y + 1]
    end

    moves.select { |coords| board.in_bounds?(coords) }
  end


end

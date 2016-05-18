require_relative 'piece'

class Pawn < Piece
  attr_reader :deltas

  def initialize(board, pos, color)
    pawn_mark = (color == :white ? "\u2659" : "\u265F")
    super(board, pos, color, pawn_mark)
  end

  def moves
    if self.color == :white
      moves = find_moves(1)
    else
      moves = find_moves(-1)
    end

    moves.select { |coords| board.in_bounds?(coords) }
  end

  def find_moves(i)
    moves = []
    x, y = self.position

    if board[[x + i, y]].is_a?(NullPiece)
      moves << [x + i, y]
      if board[[x + (2 * i), y]].is_a?(NullPiece) && (x == 1 || x == 6)
        moves << [x + (2 * i), y]
      end
    end

    unless board[[x + i, y - 1]].is_a?(NullPiece)
      moves << [x + i, y - 1]
    end

    unless board[[x + i, y + 1]].is_a?(NullPiece)
      moves << [x + i, y + 1]
    end

    moves
  end
end

require_relative  'piece'

class Knight < SteppingPiece
  KNIGHT_DELTAS = [-2, -1, 1, 2].product([-2, -1, 1, 2]).reject { |a, b| a.abs + b.abs != 3 }


  attr_reader :deltas

  def initialize(board, pos, color)
    knight_mark = (color == :white ? "\u2658" : "\u265E")
    super(board, pos, color, knight_mark)
    @deltas = KNIGHT_DELTAS

  end
end

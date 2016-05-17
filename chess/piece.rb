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
    byebug
    self.moves.include?(end_pos)
  end

  def move(end_pos)
    # raise unless self.moves.include?(end_pos)
    board.move(self.position, end_pos)
    self.position = end_pos
  end

  def to_s
    #to picture
    mark.to_s
  end
end

class SlidingPiece < Piece
  RANGE = (1..8).to_a
  NEGATIVE_RANGE = RANGE.map { |elt| -elt }

  def initialize(board, pos, color, mark)
    super
  end

  def moves
    x, y = self.position
    end_positions = deltas.map { |dx, dy| [x + dx, y + dy] }
    end_positions.select! { |pos| board.in_bounds?(pos) }
    end_positions.reject! { |pos| board[pos].color == self.color }
    end_positions.select! { |pos| no_obstructions?(pos) }
  end

  def path_to(end_pos)
    x, y = self.position
    new_x, new_y = end_pos

    max_y = [y, new_y].max
    min_y = [y, new_y].min
    max_x = [x, new_x].max
    min_x = [x, new_x].min

    path = []

    if self.position.last == new_y
      x_arr = (min_x...max_x).to_a.drop(1)
      y_arr = [new_y]

      path = x_arr.product(y_arr)
    elsif new_x == self.position.first
      x_arr = [new_x]
      y_arr = (min_y...max_y).to_a.drop(1)

      path = x_arr.product(y_arr)
    elsif (position.first - new_x).abs == (position.last - new_y).abs
      x_arr = (min_x...max_x).to_a.drop(1)
      y_arr = (min_y...max_y).to_a.drop(1)

      path = x_arr.zip(y_arr)
    end
    path
  end

  def no_obstructions?(end_pos)
    path = path_to(end_pos)
    return true if path.empty?
    path.all? { |space| board[space].is_a?(NullPiece) }
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

  attr_reader :color

  @color = :none

  def to_s
    "   "
  end
end

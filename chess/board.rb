require_relative 'piece'

class Board
  attr_accessor :board
  def initialize
    @board = Array.new(8) { Array.new(8, NullPiece.instance) }
  end

  def move(start, end_pos)
    # raise if self[start].is_a?(NullPiece) -> player.rb
    # raise unless self[start].can_move?(end_pos)
    self[end_pos] = self[start]
    self[start] = NullPiece.instance
  end

  def rows
    board
  end

  def [](pos)
    x, y = pos
    board[x][y]
  end

  def []=(pos, value)
    x, y = pos
    board[x][y] = value
  end

  def in_bounds?(pos)
    pos.all? { |coord| coord.between?(0, 7) }
  end

  def deep_dup
    dupped_board = Board.new
    dupped_board.board = rows.deep_dup
    dupped_board
  end
end

class Array
  def deep_dup
    dupped_arr = []

    self.each do |el|
      if el.is_a?(Array)
        dupped_arr << el.deep_dup
      else
        dupped_arr << el
      end
    end

    dupped_arr
  end
end

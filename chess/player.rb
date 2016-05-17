require_relative 'display'

class Player
  attr_accessor :color, :board

  def initialize(name)
    @name = name
    @display = Display.new(board)
    @color = nil
    @board = nil
  end

  def get_pos
    pos = nil

    until pos
      @display.render
      pos = @display.get_input
    end

    pos
  end

  def move
    start_pos = nil
    end_pos = nil

    until start_pos && end_pos && board[start_pos].color == color && board[start_pos].can_access?(end_pos)
      start_pos = get_pos
      end_pos = get_pos
    end
    board.move(start_pos, end_pos)
  end

end

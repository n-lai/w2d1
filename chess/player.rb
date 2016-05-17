require_relative 'display'

class Player
  attr_accessor :color, :board

  def initialize(name)
    @name = name
    @board = nil
    @display = nil
    @color = nil
  end

  def get_pos
    pos = nil
    @display = Display.new(board)

    until pos
      @display.render
      pos = @display.get_input
    end

    pos
  end

  def move
    start_pos = nil
    end_pos = nil

    p "Made it to outside of loop!"
    until start_pos && end_pos && board[start_pos].color == color && board[start_pos].can_access?(end_pos)
      p "Made it into the loop!"
      start_pos = get_pos
      end_pos = get_pos
    end
    p "Made it out of the loop!"
    p start_pos
    p end_pos
    board[start_pos].move(end_pos)
  end

end

require_relative 'display'

class Player

  def initialize(name, board)
    @name = name
    @display = Display.new(board)
  end

  def get_move
    start_pos = nil
    end_pos = nil

    until start_pos
      @display.render
      start_pos = @display.get_input
    end

    until end_pos
      @display.render
      end_pos = @display.get_input
    end

    [start_pos, end_pos]
  end

end

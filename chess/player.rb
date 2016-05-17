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

    until start_pos && end_pos && board[start_pos].color == color && board[start_pos].can_access?(end_pos)
      start_pos = get_pos
      end_pos = get_pos

      if board[start_pos].color != color
        puts "Can't move that piece."
        sleep(2)
      elsif !board[start_pos].can_access?(end_pos)
        puts "Invalid end position."
        sleep(2)
      end



    end
    board[start_pos].move(end_pos)
  end

end

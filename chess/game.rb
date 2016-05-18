require_relative 'manifest'
require 'byebug'

class Chess
  attr_accessor :board, :players
  attr_reader :display

  def initialize(white, black)
    @board = Board.new
    @players = [white, black]
    self.setup_game
  end

  def setup_game

    players.first.color = :white
    players.last.color = :black
    players.first.board = board
    players.last.board = board

    board.rows.each_with_index do |row, i|
      next if i.between?(2, 5)
      color = (i.between?(0, 1) ? :white : :black)
      row.each_index do |j|
        board[[i, j]] = backrow(color)[j] if i == 0 || i == 7
        board[[i, j]] = pawnrow(color)[j] if i == 1 || i == 6
      end
    end
  end

  def pawnrow(color)
    row_idx = (color == :white ? 1 : 6)
    (0..7).to_a.map { |i| Pawn.new(board, [row_idx, i], color)}
  end

  def backrow(color)
    row_idx = (color == :white ? 0 : 7)

    [
      Rook.new(board, [row_idx, 0], color),
      Knight.new(board, [row_idx, 1], color),
      Bishop.new(board, [row_idx, 2], color),
      Queen.new(board, [row_idx, 3], color),
      King.new(board, [row_idx, 4], color),
      Bishop.new(board, [row_idx, 5], color),
      Knight.new(board, [row_idx, 6], color),
      Rook.new(board, [row_idx, 7], color)
    ]
  end

  def play
    until over?
      play_turn
      switch_players!
    end
    announce_results
  end

  def switch_players!
    players.rotate!
  end

  def current_player
    players.first
  end

  def play_turn
    current_player.move
  end

  def announce_results
    puts "Game ended"
  end

  def over?
    (check?(:white) && checkmate?(:white)) || (check?(:black) && checkmate?(:black))
  end

  def checkmate?(color)
    own_pieces = board.rows.flatten.select { |piece| piece.color == color }
    own_moves = own_pieces.flat_map { |piece| piece.moves.map { |move| [piece.position, move] } }
    moves_test = own_moves.map do |start_pos, move|
      dup_game = Chess.new(Player.new("white"), Player.new("black"))
      dup_game.board = board.deep_dup
      dup_game.board.move(start_pos, move)
      return false unless dup_game.check?(color)
    end
    true
  end



  def check?(color)

    king = board.rows.flatten.detect { |piece| piece.is_a?(King) && piece.color == color}
    king_pos = king.position

    opponent_color = (color == :white ? :black : :white)
    opponents_pieces = board.rows.flatten.select { |piece| piece.color == opponent_color }
    opponents_moves = opponents_pieces.flat_map { |piece| piece.moves }
    opponents_moves.include?(king_pos)
  end

end



if __FILE__ == $PROGRAM_NAME
  white = Player.new("white")
  black = Player.new("black")
  game = Chess.new(white, black)
  # display = Display.new(game.board)
  game.play
  display = Display.new(game.board)
  display.render


end

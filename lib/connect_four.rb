class ConnectFour
  def initialize
    @turns = ['R', 'Y']
    @turn = 0
    @board = Array.new(6, Array.new(7, '.'))
  end

  def ask_column
    col = nil
    until ["1", "2", "3", "4", "5", "6", "7"].include?(col) do
      col = gets.chomp
    end
    col.to_i - 1
  end

  def is_full?(col)
    @board.all? { |row| row[col] != '.' }
  end
end
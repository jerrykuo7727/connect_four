class ConnectFour
  def initialize
    @turn = 'R'
    @board = Array.new(6, Array.new(7, '.'))
    @last_drop = nil
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

  def drop(col)
    row = nil
    @board.to_enum.with_index.reverse_each do |r, i|
      if r[col] == '.'
        row = i
        break
      end
    end
    @board[row][col] = @turn
    @last_drop = [row, col]
  end

  def display
    result = ""
    @board.each do |r|
      row = r.join('  ') + "\n"
      result << row
    end
    result
  end

  def line_match?
    directions = [[0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1]]
    loop do
      return false if directions.empty?
      direction = directions.shift

      disk = next_disk(direction)
      next if out_of_board?(disk)
      next if @board[disk[0]][disk[1]] != @turn

      disk = next_disk(direction)
      next if out_of_board?(disk)
      next if @board[disk[0]][disk[1]] != @turn

      disk = next_disk(direction)
      next if out_of_board?(disk)
      next if @board[disk[0]][disk[1]] != @turn

      return true
    end
  end

  private

  def next_disk(disk, direction)
    row = disk[0] + direction[0]
    col = disk[1] + direction[1]
    [row, col]
  end

  def out_of_board?(disk)
    !((0..5).include?(disk[0]) && (0..6).include?(disk[1]))
  end
end
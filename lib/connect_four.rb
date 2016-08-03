class ConnectFour
  def initialize
    @turn = 'R'
    @board = Array.new(6, Array.new(7, '.'))
    @last_drop = nil
  end

  def start
    puts '------------- Welcome to Connect Four -------------'
    puts '| First one connect a line of four wins the game! |'
    puts '---------------------------------------------------'
    puts
  end

  def ask_column
    col = nil
    if @turn == 'R'
      puts "Now is RED's turn."
    else
      puts "Now is YELLO's turn."
    end

    until ["1", "2", "3", "4", "5", "6", "7"].include?(col) do
      print "Enter column to drop disk: "
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
    puts result
    result
  end

  def line_match?
    directions = [[0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1]]
    loop do
      return false if directions.empty?
      direction = directions.shift
      disk = @last_drop

      no_match = nil
      3.times do
        disk = next_disk(disk, direction)
        if out_of_board?(disk) || @board[disk[0]][disk[1]] != @turn
          no_match = true
          break
        end
      end

      return true unless no_match
    end
  end

  def gameover
    if @turn == 'R'
      winner = 'RED wins the game!'
    else
      winner = 'YELLOW wins the game!'
    end
    puts winner
    winner
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
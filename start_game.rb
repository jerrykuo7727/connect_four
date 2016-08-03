require './lib/connect_four'

connect_four = ConnectFour.new
connect_four.start
connect_four.display

loop do
  column = connect_four.ask_column
  next if connect_four.is_full?(column)

  connect_four.drop(column)
  connect_four.display

  break if connect_four.line_match?
  connect_four.switch_player
end

connect_four.gameover

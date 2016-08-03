require 'connect_four'

describe ConnectFour do
  let(:connect_four) { ConnectFour.new }

  describe '#ask_column' do
    context 'asking user which column to drop disk' do
      it 'returns the column user input' do
        io_obj = double
        allow(connect_four).to receive(:gets).and_return(io_obj)
        allow(io_obj).to receive(:chomp).and_return("7")
        expect(connect_four.ask_column).to eql(6)
      end

      it 'asks user input again if invalid input' do
        io_obj = double
        allow(connect_four).to receive(:gets).and_return(io_obj)
        allow(io_obj).to receive(:chomp).and_return("A")
        allow(connect_four).to receive(:gets).and_return(io_obj)
        allow(io_obj).to receive(:chomp).and_return("8")
        allow(connect_four).to receive(:gets).and_return(io_obj)
        allow(io_obj).to receive(:chomp).and_return("4")
        expect(connect_four.ask_column).to eql(3)
      end
    end
  end

  describe '#is_full?' do
    context 'given the column number' do
      it 'returns true when the column is full' do
        test_board = Array.new(6, ['.', 'R', '.', 'Y', '.', '.', '.'])
        connect_four.instance_variable_set(:@board, test_board)
        expect(connect_four.is_full?(1)).to eql(true)
        expect(connect_four.is_full?(3)).to eql(true)
      end

      it 'returns false when the column is not full' do
        upper = Array.new(3, ['.', '.', '.', '.', '.', '.', '.'])
        lower = Array.new(3, ['.', 'R', '.', 'Y', '.', '.', '.'])
        test_board = upper + lower
        connect_four.instance_variable_set(:@board, test_board)

        expect(connect_four.is_full?(1)).to eql(false)
        expect(connect_four.is_full?(2)).to eql(false)
        expect(connect_four.is_full?(3)).to eql(false)
      end
    end
  end

  describe '#drop' do
    context 'given the column number' do
      let(:test_board) { [['.', '.', '.', '.', '.', '.', '.'],
                          ['.', '.', '.', '.', '.', '.', '.'],
                          ['.', 'R', '.', '.', '.', '.', '.'],
                          ['.', 'R', '.', '.', '.', '.', '.'],
                          ['.', 'R', '.', 'Y', '.', '.', '.'],
                          ['.', 'R', '.', 'Y', '.', '.', '.']] }

      it 'drops disk to the column' do
        connect_four.instance_variable_set(:@board, test_board)

        connect_four.instance_variable_set(:@turn, 'Y')
        connect_four.drop(1)
        board = connect_four.instance_variable_get(:@board)
        last_drop = connect_four.instance_variable_get(:@last_drop)
        expect(board).to eql(Array.new([['.', '.', '.', '.', '.', '.', '.'],
                                        ['.', 'Y', '.', '.', '.', '.', '.'],
                                        ['.', 'R', '.', '.', '.', '.', '.'],
                                        ['.', 'R', '.', '.', '.', '.', '.'],
                                        ['.', 'R', '.', 'Y', '.', '.', '.'],
                                        ['.', 'R', '.', 'Y', '.', '.', '.']]))
        expect(last_drop).to eql([1,1])

        connect_four.instance_variable_set(:@turn, 'R')
        connect_four.drop(2)
        board = connect_four.instance_variable_get(:@board)
        last_drop = connect_four.instance_variable_get(:@last_drop)
        expect(board).to eql(Array.new([['.', '.', '.', '.', '.', '.', '.'],
                                        ['.', 'Y', '.', '.', '.', '.', '.'],
                                        ['.', 'R', '.', '.', '.', '.', '.'],
                                        ['.', 'R', '.', '.', '.', '.', '.'],
                                        ['.', 'R', '.', 'Y', '.', '.', '.'],
                                        ['.', 'R', 'R', 'Y', '.', '.', '.']]))
        expect(last_drop).to eql([5,2])

        connect_four.instance_variable_set(:@turn, 'Y')
        connect_four.drop(3)
        board = connect_four.instance_variable_get(:@board)
        last_drop = connect_four.instance_variable_get(:@last_drop)
        expect(board).to eql(Array.new([['.', '.', '.', '.', '.', '.', '.'],
                                        ['.', 'Y', '.', '.', '.', '.', '.'],
                                        ['.', 'R', '.', '.', '.', '.', '.'],
                                        ['.', 'R', '.', 'Y', '.', '.', '.'],
                                        ['.', 'R', '.', 'Y', '.', '.', '.'],
                                        ['.', 'R', 'R', 'Y', '.', '.', '.']]))
        expect(last_drop).to eql([3,3])
      end
    end
  end

  describe '#display' do
    it 'displays the board and disks' do
      test_board = [['.', '.', '.', '.', '.', '.', '.'],
                    ['.', '.', '.', '.', '.', '.', '.'],
                    ['.', 'R', '.', '.', '.', '.', '.'],
                    ['.', 'R', '.', '.', '.', '.', '.'],
                    ['.', 'R', '.', 'Y', '.', '.', '.'],
                    ['.', 'R', '.', 'Y', '.', '.', '.']]
      result = ".  .  .  .  .  .  .\n" <<
               ".  .  .  .  .  .  .\n" <<
               ".  R  .  .  .  .  .\n" << 
               ".  R  .  .  .  .  .\n" <<
               ".  R  .  Y  .  .  .\n" <<
               ".  R  .  Y  .  .  .\n"

      connect_four.instance_variable_set(:@board, test_board)
      expect(connect_four.display).to eql(result)
    end
  end
=begin
  describe '#line_match?' do
    context 'for 4 same disks on the board' do
      it 'returns true when lateral line' do
        test_board = [['.', '.', '.', '.', '.', '.', '.'],
                      ['.', '.', '.', '.', '.', '.', '.'],
                      ['.', 'R', '.', '.', '.', '.', '.'],
                      ['.', 'R', 'R', '.', '.', '.', '.'],
                      ['.', 'Y', 'Y', 'Y', 'Y', '.', '.'],
                      ['.', 'R', 'R', 'R', 'Y', '.', '.']]
        connect_four.instance_variable_set(:@board, test_board)
        expect(connect_four.line_match?).to eql(true)
      end

      it 'returns true when portrait line' do
        test_board = [['.', '.', '.', '.', '.', '.', '.'],
                      ['.', '.', '.', '.', '.', '.', '.'],
                      ['.', 'R', '.', '.', '.', '.', '.'],
                      ['.', 'R', 'R', '.', '.', '.', '.'],
                      ['.', 'Y', 'Y', 'Y', 'Y', '.', '.'],
                      ['.', 'R', 'R', 'R', 'Y', '.', '.']]
        connect_four.instance_variable_set(:@board, test_board)
        expect(connect_four.line_match?).to eql(true)
      end

      it 'returns true when diagonal line' do
        test_board = [['.', '.', '.', '.', '.', '.', '.'],
                      ['.', '.', '.', '.', 'Y', '.', '.'],
                      ['.', 'R', '.', '.', 'Y', '.', '.'],
                      ['.', 'R', 'Y', '.', 'Y', '.', '.'],
                      ['.', 'Y', 'Y', 'R', 'Y', '.', '.'],
                      ['.', 'R', 'R', 'Y', 'R', '.', '.']]
        connect_four.instance_variable_set(:@board, test_board)
        expect(connect_four.line_match?).to eql(true)
      end

      it 'returns false when no line' do
        test_board = [['.', '.', '.', '.', '.', '.', '.'],
                      ['.', '.', '.', '.', '.', '.', '.'],
                      ['.', 'R', '.', '.', '.', '.', '.'],
                      ['.', 'R', 'R', 'Y', '.', '.', '.'],
                      ['.', 'Y', 'Y', 'Y', 'R', '.', '.'],
                      ['.', 'R', 'R', 'R', 'Y', '.', '.']]
        connect_four.instance_variable_set(:@board, test_board)
        expect(connect_four.line_match?).to eql(false)
      end
    end
  end
=end
  describe '#next_disk' do
    context 'given the direction toward' do
      it 'returns the next disk' do
        connect_four.instance_variable_set(:@last_drop, [2, 3])
        expect(connect_four.send(:next_disk, [1, -1])).to eql([3, 2])
        expect(connect_four.send(:next_disk, [-1, 0])).to eql([1, 3])
      end
    end
  end

  describe '#out_of_board?' do
    context 'given a disk postion' do
      it 'returns true when in board' do
        expect(connect_four.send(:out_of_board?, [1, 2])).to eql(true)
        expect(connect_four.send(:out_of_board?, [3, 0])).to eql(true)
        expect(connect_four.send(:out_of_board?, [5, 6])).to eql(true)
      end

      it 'returns false when out of board' do
        expect(connect_four.send(:out_of_board?, [-1, 5])).to eql(false)
        expect(connect_four.send(:out_of_board?, [6, 2])).to eql(false)
        expect(connect_four.send(:out_of_board?, [1, 7])).to eql(false)
      end
    end
  end
end
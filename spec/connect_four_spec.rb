require 'connect_four'

describe ConnectFour do
  let(:connect_four) { ConnectFour.new }

  describe '#ask_column' do
    context 'asking user which column to drop disk' do
      it 'returns the column user input' do
        io_obj = double
        allow(connect_four).to receive(:gets).and_return(io_obj)
        allow(io_obj).to receive(:chomp).and_return("7")
        expect(connect_four.ask_column).to eql(7)
      end
      it 'asks user input again if invalid input' do
        io_obj = double
        allow(connect_four).to receive(:gets).and_return(io_obj)
        allow(io_obj).to receive(:chomp).and_return("A")
        allow(connect_four).to receive(:gets).and_return(io_obj)
        allow(io_obj).to receive(:chomp).and_return("8")
        allow(connect_four).to receive(:gets).and_return(io_obj)
        allow(io_obj).to receive(:chomp).and_return("4")
        expect(connect_four.ask_column).to eql(4)
      end
    end
  end
end
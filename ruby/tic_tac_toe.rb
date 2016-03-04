class Game

	def initialize(player1, player2)
		@player1_name = player1
		@player2_name = player2
		@grid = [["0","1","2"],["3","4","5"],["6","7","8"]]
	end

	def turn(name, cell)
		if name == @player1_name
			@player_symbol = "X"
			@player_name = name
		else
			@player_symbol = "O"
			@player_name = name
		end
		if mark_on_grid(@player_symbol, cell)
			return false
		end
	end

	def display_grid
		puts "\n"
		@grid.each do |row|
			row.each do |col|
				print col
				print "  "
			end
			print "\n"
		end
		@grid.each do |x| #checking if grid is full or not.....
			x.each do |y|
				if /[0-9]/.match(y)
					return
				end
			end
		end
		puts "------------------Match Draw----------------"
		exit 0
	end

	private
	
	def mark_on_grid(player_symbol, cell)
		cell_number_to_indices = {
			0 => [0,0],
			1 => [0,1],
			2 => [0,2],
			3 => [1,0],
			4 => [1,1],
			5 => [1,2],
			6 => [2,0],
			7 => [2,1],
			8 => [2,2]
		}
		indices = cell_number_to_indices[cell]
		place_holder = @grid[indices[0]][indices[1]]
		if place_holder == "X" || place_holder == "O" #checking if cell is empty or occupied
			puts "Symbol already exists in '#{cell}'cell"
			return true 
		end
		@grid[indices[0]][indices[1]] = player_symbol
		display_grid
		does_player_won?(@grid, player_symbol, indices)
	end

	def does_player_won?(grid, player_symbol, indices)
		row = indices[0]
		col = indices[1]
		horizontal_check(row)
		vertical_check(col)
		diagonal1_check
		diagonal2_check
	end

	def horizontal_check(row)
		for i in 0..2 do
			unless @grid[row][i] == @player_symbol
				return
			end
		end
		winning_message
	end

	def vertical_check(col)
		for i in 0..2 do
			unless @grid[i][col] == @player_symbol
				return
			end
		end
		winning_message
	end

	def diagonal1_check
		for index in 0..2 do
			unless @grid[index][index] == @player_symbol
				return
			end
		end
		winning_message
	end

	def diagonal2_check
		col = 2
		for row in 0..2 do
			unless @grid[row][col] == @player_symbol
				return
			end
			col -= 1
		end
		winning_message
	end

	def winning_message
		puts "\nCongrats!!!!!! '#{@player_name}' you won the game"
		exit 0
	end

end

puts "Tic - Tac - Toe Game starts now.....\n"
puts "\nEnter player1 name"
player1_name = gets.chomp
puts "\nEnter player2 name"
player2_name = gets.chomp

tic_tac_toe = Game.new(player1_name, player2_name)

puts "\nEmpty Grid with cell numbers"
num = 0
for i in 0..2 do
	for j in 0..2 do
		print num
		print "  "
		num += 1 
	end
	print "\n"
end
while (true)
	begin
		begin	
			puts "\n'#{player1_name}' enter the cell number(0-8) to put X (Cross)"
			cell = gets.chomp.to_i
		end while cell < 0 || cell > 8
		success = tic_tac_toe.turn(player1_name, cell)
	end while success == false
	begin
		begin
			puts "\n'#{player2_name}' enter the cell number(0-8) to put O (Nought)"
			cell = gets.chomp.to_i
		end while cell < 0 || cell > 8
		success = tic_tac_toe.turn(player2_name, cell)
	end while success == false
end

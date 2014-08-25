class Grid
	def initialize(puzzle)
		@cells = Array.new(9) { Array.new(9) { Cell.new }}
		assign_starting_values(puzzle)
	end

	attr_reader :cells

	private

	def assign_starting_values(puzzle)
		puzzle = convert_to_array(puzzle)
		puzzle.each_with_index do |row, row_i|
			row.each_with_index do |col, col_i|
				@cells[row_i][col_i].value = puzzle[row_i][col_i]
			end
		end
	end

	def convert_to_array(puzzle)
		numbers = puzzle.split('').collect { |str| str.to_i }
		numbers.each_slice(9).to_a
	end

	public

	def inspect
		@cells.each do |row|
			row.each do |cell|
				print "#{cell.value} "
			end
			puts
		end
	end

	def solve
		outstanding_before = outstanding_cells
		no_more_solvable = false

		until solved? || no_more_solvable
			solve_iteration
			no_more_solvable = (outstanding_before == outstanding_cells)
			outstanding_before = outstanding_cells
		end
	end

	def solve_iteration
		assign_neighbours
		@cells.flatten.each(&:solve)
	end

	def solved?
		@cells.flatten.all?(&:filled_in?)
	end

	def outstanding_cells
		@cells.flatten.count { |cell| !cell.filled_in? }
	end

	def assign_neighbours
		@cells.each_with_index do |row, row_i|
			row.each_with_index do |cell, col_i| 
				
				cell.neighbours += row
				column = @cells.collect { |row| row[col_i] }
				cell.neighbours += column
				
				assign_box_neighbours(row_i, col_i, cell)
				remove_self_and_duplicates(cell)
			end
		end
	end

	private

	def assign_box_neighbours(row, col, cell)
		box_row, box_col = get_box(row, col)
		box_row.each do |box_r|
			box_col.each do |box_c|
				cell.neighbours << @cells[box_r][box_c]
			end
		end
	end

	def get_box(row, col)
		boxes = [[0,1,2], [3,4,5], [6,7,8]]
		boxes.each do |box|
			row = box if box.include?(row)
			col = box if box.include?(col)
		end
		return row, col
	end

	def remove_self_and_duplicates(cell)
		cell.neighbours.delete(cell)
		cell.neighbours.uniq!
	end
end
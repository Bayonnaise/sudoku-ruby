class Grid
	def initialize(puzzle)
		@cells = Array.new(81) { Cell.new }
		assign_starting_values(puzzle)
	end

	attr_reader :cells

	def assign_starting_values(puzzle)
		puzzle = convert_to_array(puzzle)
		(0..80).each { |i| @cells[i].value = puzzle[i] }
	end

	def convert_to_array(puzzle)
		puzzle.split('').collect { |str| str.to_i }.to_a
	end

	def solve
		outstanding_before = outstanding_cells
		no_more_solvable = false

		until solved? || no_more_solvable
			solve_iteration
			no_more_solvable = (outstanding_before == outstanding_cells)
			outstanding_before = outstanding_cells
		end

		try_harder unless solved?
	end

	def solved?
		@cells.all?(&:filled_in?)
	end

	def outstanding_cells
		@cells.count { |cell| !cell.filled_in? }
	end

	def solve_iteration
		assign_neighbours
		@cells.each(&:solve)
	end

	def assign_neighbours
		@cells.each_with_index do |cell, index|
			cell.neighbours += get_row(index)
			cell.neighbours += get_column(index)
			cell.neighbours += get_box(index)
			remove_self_and_duplicates(cell)
		end
	end

	def first_unsolved
		@cells.detect{ |cell| !cell.filled_in? }
	end

	def try_harder
		blank_cell = first_unsolved

		blank_cell.candidates.each do |candidate|
			blank_cell.assume(candidate)
			board = replicate
			board.solve
			steal_solution(board) and return if board.solved?
		end
	end

	def replicate
		board = ""
		@cells.each do |cell|
			if cell.assumed?
				board += cell.assumed_value.to_s
			else
				board += cell.value.to_s
			end
		end
		Grid.new(board)
	end

	def steal_solution(other_grid)
		@cells = other_grid.cells
	end

	def solution
		@cells.map(&:value)*""
	end

	def display
		@cells.each_with_index do |cell, index|
			print "#{cell.value} "
			puts if [8,17,26,35,44,53,62,71,80].include?(index)
		end
	end

	private

	def get_row(index)
		@cells.slice(index - index % 9, 9)
	end

	def get_column(index)
		@cells.drop(index % 9).each_slice(9).map(&:first)
	end

	def get_box(index)
		box = []
		box_row, box_col = locate_box(index)

		box_row.each do |row|
			box << @cells[row * 9 + box_col.first, 3]
		end

		return box.flatten
	end

	def locate_box(index)
		row = (index - index % 9) / 9
		col = index % 9

		triplets = [[0,1,2], [3,4,5], [6,7,8]]
		triplets.each do |triplet|
			row = triplet if triplet.include?(row)
			col = triplet if triplet.include?(col)
		end

		return row, col
	end

	def remove_self_and_duplicates(cell)
		cell.neighbours.delete(cell)
		cell.neighbours.uniq!
	end
end
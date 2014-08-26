class Grid
	def initialize(puzzle_string)
		@cells = Array.new(81) { Cell.new }
		assign_starting_values_from(puzzle_string)
	end

	attr_reader :cells

	def solve
		unsolved_count_before = unsolved_count
		no_more_solvable_cells = false

		until solved? || no_more_solvable_cells
			solve_iteration
			no_more_solvable_cells = (unsolved_count_before == unsolved_count)
			unsolved_count_before = unsolved_count
		end

		advanced_solve unless solved?
	end

	def solved?
		cells.all?(&:filled_in?)
	end

	def unsolved_count
		cells.reject(&:filled_in?).count
	end

	def solve_iteration
		update_all_neighbours
		cells.each(&:solve)
	end

	def update_all_neighbours
		cells.each_with_index do |cell, index|
			cell.neighbours += neighbours_in_row_at(index)
			cell.neighbours += neighbours_in_column_at(index)
			cell.neighbours += neighbours_in_box_at(index)
			remove_self_and_duplicate_neighbours_for(cell)
		end
	end

	def advanced_solve
		first_unsolved_cell.candidates.each do |candidate|
			first_unsolved_cell.assume(candidate)
			test_grid = replicate_with_assumed_values
			test_grid.solve
			steal_solution_from(test_grid) and return if test_grid.solved?
		end
	end

	def first_unsolved_cell
		cells.reject(&:filled_in?).first
	end

	def replicate_with_assumed_values
		replica_puzzle_string = ""
		cells.each do |cell|
			if cell.assumed?
				replica_puzzle_string += cell.assumed_value.to_s
			else
				replica_puzzle_string += cell.value.to_s
			end
		end
		Grid.new(replica_puzzle_string)
	end

	def steal_solution_from(test_grid)
		@cells = test_grid.cells
	end

	def solution_string
		@cells.map(&:value)*""
	end

	def display
		puts "Solution:"
		cells.each_with_index do |cell, index|
			print "#{cell.value} "
			puts if [8,17,26,35,44,53,62,71,80].include?(index)
		end
	end

	private

	def assign_starting_values_from(puzzle_string)
		puzzle_array = make_array_from(puzzle_string)
		(0..80).each { |i| cells[i].value = puzzle_array[i] }
	end

	def make_array_from(puzzle_string)
		puzzle_string.split('').collect { |str| str.to_i }.to_a
	end

	def neighbours_in_row_at(index)
		cells.slice(index - index % 9, 9)
	end

	def neighbours_in_column_at(index)
		cells.drop(index % 9).each_slice(9).map(&:first)
	end

	def neighbours_in_box_at(index)
		row = (index / 9)
		col = index % 9
		triplets = [[0,1,2], [3,4,5], [6,7,8]]

		triplets.each do |triplet|
			row = triplet if triplet.include?(row)
			col = triplet if triplet.include?(col)
		end

		retrieve_box_cells_at(row, col)
	end

	def retrieve_box_cells_at(row, col)
		box = []
		row.each do |cell|
			box << @cells[cell * 9 + col.first, 3]
		end
		box.flatten
	end

	def remove_self_and_duplicate_neighbours_for(cell)
		cell.neighbours.delete(cell)
		cell.neighbours.uniq!
	end
end
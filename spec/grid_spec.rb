require 'grid'
require 'cell'

describe 'Grid' do
	let(:easy_puzzle) { '015003002000100906270068430490002017501040380003905000900081040860070025037204600' }
	let(:hard_puzzle) { '800000000003600000070090200050007000000045700000100030001000068008500010090000400' }

	context 'when initialising' do
		let(:grid) { Grid.new(easy_puzzle) }

		it 'should have 81 cells' do
			expect(grid.cells.length).to eq 81
		end

		it 'should have an unsolved first cell' do
			expect(grid.cells[0]).not_to be_filled_in
		end

		it 'should have a solved second cell with a value 1' do
			expect(grid.cells[1]).to be_filled_in
			expect(grid.cells[1].value).to eq 1
		end
	end	

	context "solving easy sudoku" do
		let(:grid) { Grid.new(easy_puzzle) }

		it 'can show each cell its neighbours' do
			grid.update_all_neighbours
			expect(grid.cells[0].neighbours.size).to eq 20
			expect(grid.cells[80].neighbours.size).to eq 20
		end

		it 'can solve a cell' do
			grid.update_all_neighbours
			grid.cells[0].solve
			expect(grid.cells[0].value).to eq 6
			expect(grid.cells[0]).to be_filled_in
		end

		it 'can get the number of outstanding cells' do
			expect(grid.unsolved_count).to eq 41
		end

		it 'can perform one iteration of solving cells' do
			unsolved_count_before = grid.unsolved_count
			grid.solve_iteration
			expect(grid.unsolved_count).to be < unsolved_count_before
		end

    it "can solve the puzzle" do
      expect(grid.solved?).to be false
      grid.solve
      expect(grid.solved?).to be true
      expect(grid.solution_string).to eq('615493872348127956279568431496832517521746389783915264952681743864379125137254698')
    	grid.display
    end
  end

  context 'solving hard sudoku' do
  	let(:grid) { Grid.new(hard_puzzle) }

  	it 'can find the first unsolved cell' do
  		expect(grid.first_unsolved_cell).to eq grid.cells[1]
  	end

  	it 'can replicate a board with an assumed value' do
  		grid.cells[1].assume(1)
  		new_grid = grid.replicate_with_assumed_values
  		expect(new_grid.cells[1].value).to eq 1
  	end

  	it 'can steal the solution from another board' do
  		grid2 = Grid.new('9' * 81)
  		grid.steal_solution_from(grid2)
  		expect(grid.cells[50].value).to eq 9
  	end

  	it "can solve the puzzle" do
      expect(grid.solved?).to be false
      grid.solve
      expect(grid.solved?).to be true
      grid.display
    end
  end

  context 'solving really hard sudoko' do
  	it 'can solve an empty grid' do
  		grid = Grid.new('0' * 81)
  		expect(grid.solved?).to be false
      grid.solve
      expect(grid.solved?).to be true
      grid.display
  	end
  end
end
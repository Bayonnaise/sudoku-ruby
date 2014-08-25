describe 'Grid' do
	let(:puzzle) { '015003002000100906270068430490002017501040380003905000900081040860070025037204600' }
	let(:grid) { Grid.new(puzzle) }

	context 'when initialising' do
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

	context "solving sudoku" do
		it 'can show each cell its neighbours' do
			grid.assign_neighbours
			expect(grid.cells[0].neighbours.size).to eq 20
			expect(grid.cells[80].neighbours.size).to eq 20
		end

		it 'can solve a cell' do
			grid.assign_neighbours
			grid.cells[0].solve
			expect(grid.cells[0].value).to eq 6
			expect(grid.cells[0]).to be_filled_in
		end

		it 'can get the number of outstanding cells' do
			expect(grid.outstanding_cells).to eq 41
		end

		it 'can perform one iteration of solving cells' do
			outstanding_before = grid.outstanding_cells
			grid.solve_iteration
			expect(grid.outstanding_cells).to be < outstanding_before
		end

		it 'breaks out of the cycle if too hard to solve' do
			hard_grid = Grid.new("800000000003600000070090200050007000000045700000100030001000068008500010090000400")
			hard_grid.solve
			expect(hard_grid).not_to be_solved
		end

    it "can solve the puzzle" do
      expect(grid.solved?).to be false
      grid.solve
      expect(grid.solved?).to be true
      expect(grid.solution).to eq('615493872348127956279568431496832517521746389783915264952681743864379125137254698')
    end
  end
end
describe 'Cell' do
	let(:cell) { Cell.new }

	context 'initialising' do
		it 'is unsolved when initialized' do
			expect(cell.value).to eq 0
		end

		it 'has a list of possible candidates' do
			expect(cell.candidates).to eq [1,2,3,4,5,6,7,8,9]
		end
	end

	context 'solving easy sudoku' do
		it 'can be filled_in' do
			cell.value = 5
			expect(cell).to be_filled_in
		end

		it 'can check what values are possible' do
			cell.neighbours += [Cell.new(2), Cell.new(5), Cell.new(9)]
			cell.update_candidates
			expect(cell.candidates).to eq [1,3,4,6,7,8]
		end

		it 'can solve itself if only one value remains' do
			cell.candidates = [3]
			cell.solve
			expect(cell.value).to eq 3
		end
	end

	context 'solving hard sudoku' do
		it 'can assume a value' do
			cell.assume(6)
			expect(cell.assumed_value).to eq 6
			expect(cell).to be_assumed
		end
	end
end
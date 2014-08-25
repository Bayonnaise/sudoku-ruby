class Cell
	def initialize(value = 0)
		@value = value
		@neighbours = []
		@candidates = [1,2,3,4,5,6,7,8,9]
	end

	attr_accessor :value, :neighbours, :candidates

	def filled_in?
		@value > 0
	end

	def update_candidates
		@neighbours.each do |cell|
			@candidates.delete(cell.value)
		end
	end

	def solve
		return if filled_in?

		update_candidates
		@value = @candidates.first if @candidates.length == 1
	end
end
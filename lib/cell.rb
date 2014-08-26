class Cell
	def initialize(value = 0)
		@value = value
		@neighbours = []
		@candidates = [1,2,3,4,5,6,7,8,9]
		@assumed_value = 0
	end

	attr_accessor :value, :neighbours, :candidates
	attr_reader :assumed_value

	def filled_in?
		value > 0
	end

	def solve
		return if filled_in?

		update_candidates
		@value = candidates.first if candidates.length == 1
	end

	def update_candidates
		neighbours.each do |cell|
			candidates.delete(cell.value)
		end
	end

	def assume(value)
		@assumed_value = value
	end

	def assumed?
		assumed_value > 0
	end
end
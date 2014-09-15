## Ruby Sudoku solver [![Code Climate](https://codeclimate.com/github/Bayonnaise/sudoku-ruby/badges/gpa.svg)](https://codeclimate.com/github/Bayonnaise/sudoku-ruby)

Objectives
--
Build a test-driven Sudoku solver in Ruby. It should accept a Sudoku starting grid as an 81-digit string...

```ruby
"015003002000100906270068430490002017501040380003905000900081040860070025037204600"
```

...and return a solved string...

```ruby
"615493872348127956279568431496832517521746389783915264952681743864379125137254698" 
```

It should also be able to display the solved grid in the terminal.

Status: Complete
--
For easy Sudoku puzzles, the solve method loops through each cell, examining its neighbours and whittling down the candidates through deduction.

```ruby
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
```

Hard Sudoku puzzles with multiple solutions are solved using recursion. After exhausting the solve method it calls advanced_solve, which assumes the value of an unsolved cell and recursively calls solve again. It 'steals' the first solved grid it discovers, and ends the cycle.

```ruby
def advanced_solve
	first_unsolved_cell.candidates.each do |candidate|
		first_unsolved_cell.assume(candidate)
		test_grid = replicate_with_assumed_values
		test_grid.solve
		steal_solution_from(test_grid) and return if test_grid.solved?
	end
end
```

Tools
--
- Ruby
- Rspec

How to run
--

```shell
git clone https://github.com/Bayonnaise/sudoku-ruby.git
cd sudoku-ruby
irb
grid = Grid.new(' * your 81-digit puzzle string * ')
grid.solve
grid.display
```

How to test
--

```shell
git clone https://github.com/Bayonnaise/sudoku-ruby.git
cd sudoku-ruby
rspec
```

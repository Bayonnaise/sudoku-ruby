## Sudoku solver

Objectives
--
Build a test-driven Sudoku solver in Ruby. It should accept a Sudoku grid as an 81-digit string (blank cells are 0s) and return a solution. It should also be able to display the solved grid.

Status: Complete
--
For easy Sudoku puzzles, the solve method loops through each cell, examining its neighbours and whittling down the candidates through deduction.

For hard Sudoku puzzles with multiple solutions, it exhausts the simple solve method, then calls the try_harder method, which recursively assumes the value of unsolved cells until a solution is reached. It then steals that solution and ends its cycle.

It can also use this method to solve an empty Sudoku grid.

Tools
--
- Ruby
- Unit tests in Rspec

How to run
--
```
git clone https://github.com/Bayonnaise/sudoku-ruby.git
cd sudoku-ruby
irb
grid = Grid.new(' * your 81-digit puzzle string * ')
grid.solve
```

How to run tests
--
```
git clone https://github.com/Bayonnaise/sudoku-ruby.git
cd sudoku-ruby
rspec
```
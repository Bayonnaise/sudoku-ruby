## Sudoku solver

Objectives
--
Build a test-driven Sudoku solver application in Ruby. It should accept a Sudoku grid in the form of an 81-digit string - with blank cells represented as 0s - and return a solution in the same format. It should also be able to display the solved grid.

Status: complete
--
For easy Sudoku puzzles, the solve method loops through each cell, examining its neighbours and whittling down the candidates through simple deduction.

For harder Sudoku puzzles, where there are multiple potential solutions, it loops through the simple solve method until it can't solve any more cells. Then it calls the try_harder method, which recursively makes assumptions about unsolved cell values until one leads to a solution down the line. It then steals that solution and ends its cycle.

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
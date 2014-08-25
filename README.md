## Sudoku solver

Objectives
--
Build a test-driven Sudoku solver application in Ruby. It should accept a Sudoku grid in the form of an 81-digit string - with blank cells represented as 0s - and return a solution in the same format. It should also be able to display the solved grid.

Status
--
Currently loops its simple solve method until no further changes can be made, which is enough to solve 'easy' puzzles where each cell only has one valid solution.

Next step is to extend the code to be able to solve 'hard' Sudoku puzzles, where multiple potential solutions exist.

Tools
--
- Ruby
- Unit tests in Rspec

How to run tests
--
```
git clone https://github.com/Bayonnaise/sudoku-ruby.git
cd sudoku-ruby
rspec
```
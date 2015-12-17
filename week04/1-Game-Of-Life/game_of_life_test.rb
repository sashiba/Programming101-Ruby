require 'minitest/autorun'

require_relative 'solution'

class SolutionTest < Minitest::Test
  def test_the_truth
    assert true
  end

  def test_indexing_true
    board = GameOfLife::Board.new [1, 2], [1, 3], [5, 6]

    assert_equal true, board[1, 2]
  end

  def test_indexing_false
    board = GameOfLife::Board.new [1, 2], [1, 3], [5, 6]

    assert_equal false, board[0, 2]
  end

  def test_count
    board = GameOfLife::Board.new [1, 2], [1, 3], [5, 6]

    assert_equal 3, board.count
  end

  def test_next_generation_with_revived_cell
    board = GameOfLife::Board.new [1, 2], [1, 3], [1, 4]
    next_gen = board.next_generation

    assert_equal true, next_gen[0, 3]
  end

  def test_next_generation_with_dead_cell
    board = GameOfLife::Board.new [1, 2], [1, 3], [1, 4]
    next_gen = board.next_generation

    assert_equal false, next_gen[1, 2]
  end

  def test_next_generation_count
    board = GameOfLife::Board.new [1, 2], [1, 3], [1, 4]
    next_gen = board.next_generation

    assert_equal 3, next_gen.count
  end
end

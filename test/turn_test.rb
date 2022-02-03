# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative '../lib/turn'
require_relative '../lib/card'

class TurnTest < MiniTest::Test
  def setup
    @card = Card.new('What is the capital of Alaska?', 'Juneau', :Geography)
    @turn_correct = Turn.new('Juneau', @card)
    @turn_incorrect = Turn.new('Mercury', @card)
  end

  def test_card
    assert_equal(@card, @turn_correct.card)
  end

  def test_guess
    assert_equal('Juneau', @turn_correct.guess)
  end

  def test_answer_correct
    assert_equal(true, @turn_correct.correct?)
  end

  def test_feedback_correct
    assert_equal('Correct!', @turn_correct.feedback)
  end

  def test_answer_incorrect
    assert_equal(false, @turn_incorrect.correct?)
  end

  def test_feedback_incorrect
    assert_equal('Incorrect', @turn_incorrect.feedback)
  end
end

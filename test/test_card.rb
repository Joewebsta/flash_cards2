# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative '../lib/card'

class CardTest < MiniTest::Test
  def setup
    @card = Card.new('What is the capital of Alaska?', 'Juneau', :Geography)
  end

  def test_card_question
    question = 'What is the capital of Alaska?'
    assert_equal(question, @card.question)
  end

  def test_card_answer
    answer = 'Juneau'
    assert_equal(answer, @card.answer)
  end

  def test_card_category
    assert_equal(:Geography, @card.category)
  end
end

# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative '../lib/card'
require_relative '../lib/deck'
require_relative '../lib/turn'
require_relative '../lib/round'

class RoundTest < MiniTest::Test
  def setup
    @card1 = Card.new('What is the capital of Alaska?', 'Juneau', :Geography)
    @card2 = Card.new('The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?', 'Mars', :STEM)
    @card3 = Card.new('Describe in words the exact direction that is 697.5° clockwise from due north?', 'North north west', :STEM)
    @cards = [@card1, @card2, @card3]
    @deck = Deck.new(@cards)
    @round = Round.new(@deck)
  end

  def test_round_turns_start_empty
    assert_equal([], @round.turns)
  end

  def test_current_card
    assert_equal(@card1, @round.current_card)
  end

  def test_take_turn
    turn = @round.take_turn('Juneau')
    assert_equal(1, @round.turns.size)
    assert_equal(@card2, @round.current_card)
    assert_instance_of(Turn, turn)
  end

  def test_number_correct
    @round.take_turn('Juneau')
    assert_equal(1, @round.number_correct)
  end
end

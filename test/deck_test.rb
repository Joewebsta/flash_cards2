# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative '../lib/deck'
require_relative '../lib/card'

class DeckTest < MiniTest::Test
  def setup
    @card1 = Card.new('What is the capital of Alaska?', 'Juneau', :Geography)
    @card2 = Card.new('The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?', 'Mars', :STEM)
    @card3 = Card.new('Describe in words the exact direction that is 697.5° clockwise from due north?', 'North north west', :STEM)
    @cards = [@card1, @card2, @card3]
    @deck = Deck.new(@cards)
  end

  def test_cards
    assert_equal(@cards, [@card1, @card2, @card3])
  end

  def test_count
    assert_equal(3, @deck.count)
  end

  def test_cards_in_category_valid1
    assert_equal([@card2, @card3], @deck.cards_in_category(:STEM))
  end

  def test_cards_in_category_valid2
    assert_equal([@card1], @deck.cards_in_category(:Geography))
  end

  def test_cards_in_category_invalid
    assert_equal([], @deck.cards_in_category('Pop Culture'))
  end
end

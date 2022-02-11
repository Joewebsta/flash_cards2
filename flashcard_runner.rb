# frozen_string_literal: true

require_relative 'lib/card'
require_relative 'lib/deck'
require_relative 'lib/turn'
require_relative 'lib/round'

card1 = Card.new('What is the capital of Alaska?', 'Juneau', :Geography)
card2 = Card.new('The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?', 'Mars', :STEM)
card3 = Card.new('Describe in words the exact direction that is 697.5° clockwise from due north?', 'North north west', :STEM)
cards = [card1, card2, card3]
deck = Deck.new(cards)
round = Round.new(deck)

round.start
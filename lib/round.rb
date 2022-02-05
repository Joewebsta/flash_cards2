# frozen_string_literal: true

require_relative('card')
require_relative('turn')
require_relative('deck')

class Round
  attr_reader :deck, :turns

  def initialize(deck)
    @deck = deck
    @cards = deck.cards
    @turns = []
  end

  def current_card
    @cards.first
  end

  def take_turn(guess)
    turn = Turn.new(guess, current_card)
    @turns << turn
    advance_deck_card
    turn
  end

  def number_correct
    turns.filter(&:correct?).size
  end

  private

  def advance_deck_card
    @cards.delete_at(0)
  end
end

card1 = Card.new('What is the capital of Alaska?', 'Juneau', :Geography)
card2 = Card.new('The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?', 'Mars', :STEM)
card3 = Card.new('Describe in words the exact direction that is 697.5° clockwise from due north?', 'North north west', :STEM)
deck = Deck.new([card1, card2, card3])
round = Round.new(deck)

# p round.deck
# p round.turns
# p deck.cards
#
new_turn = round.take_turn('Juneau')
# p new_turn
# p new_turn.class
# p new_turn.correct?

# p round.turns
# p round.number_correct

# p round.current_card.question
round.take_turn('Venus')
# p round.turns.count
# p round.turns.last.feedback
p round.number_correct

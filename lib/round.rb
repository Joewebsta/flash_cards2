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
    correct_turns.size
  end

  def number_correct_by_category(category)
    correct_turns_by_category(category).size
  end

  def percent_correct
    (number_correct.to_f / turns.size * 100).truncate(2)
  end

  def percent_correct_by_category(category)
    num_correct = number_correct_by_category(category)
    num_turns = number_turns_by_category(category)
    (num_correct.to_f / num_turns * 100).truncate(2)
  end

  private

  def advance_deck_card
    @cards.delete_at(0)
  end

  def correct_turns
    turns.filter(&:correct?)
  end

  def correct_turns_by_category(category)
    correct_turns.filter { |turn| turn.card_category == category }
  end

  def number_turns_by_category(category)
    turns.filter { |turn| turn.card_category == category }.size
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
round.take_turn('Juneau')
round.take_turn('Mars')
round.take_turn('North north wes')
# p round.number_correct
# p round.current_card.question
# p round.turns
# p round.number_correct

# p round.number_correct_by_category(:Geography)
# p round.number_correct_by_category(:STEM)
p round.percent_correct

p round.percent_correct_by_category(:STEM)
p round.percent_correct_by_category(:Geography)

# p round.turns.count
# p round.turns.last.feedback
#

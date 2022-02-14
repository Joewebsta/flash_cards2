# frozen_string_literal: true

require_relative('card')
require_relative('turn')
require_relative('deck')

class Round
  attr_reader :deck, :turns

  def initialize(deck)
    @deck = deck
    @cards = @deck.cards.dup
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

  def total_deck_cards
    @deck.count
  end

  def current_card_pos
    @deck.cards.find_index(current_card) + 1
  end

  def number_correct
    correct_turns.size
  end

  def number_correct_by_category(category)
    correct_turns_by_category(category).size
  end

  def percent_correct
    (number_correct.to_f / turns.size * 100).round
  end

  def percent_correct_by_category(category)
    num_correct = number_correct_by_category(category)
    num_turns = number_turns_by_category(category)
    (num_correct.to_f / num_turns * 100).round
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

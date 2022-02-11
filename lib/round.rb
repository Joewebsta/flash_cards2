# frozen_string_literal: true

require_relative('card')
require_relative('turn')
require_relative('deck')

class Round
  attr_reader :deck, :turns

  def initialize(deck)
    @deck = deck
    @cards = deck.cards.dup
    @turns = []
  end

  def start
    puts intro

    loop do
      break if @turns.size == @deck.count

      puts "This is card number #{@turns.size + 1} out of #{@deck.count}."
      puts current_card.question
      answer = gets.chomp
      take_turn(answer)
    end
  end

  def intro
    <<~INTRO
      Welcome! You're playing with #{@cards.size} cards.
      -------------------------------------------------
    INTRO
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

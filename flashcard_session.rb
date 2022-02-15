# frozen_string_literal: true

require_relative 'lib/card_converter'
require_relative 'lib/deck'
require_relative 'lib/turn'
require_relative 'lib/round'

class FlashCardSession
  def start
    display_intro_message
    review_cards until turns_completed?
    game_over_and_stats
  end

  private

  def initialize
    cards = CardConverter.create_cards('data/cards.csv')
    deck = Deck.new(cards)
    @round = Round.new(deck)
  end

  def display_intro_message
    puts <<~INTRO
      Welcome! You're playing with #{@round.total_deck_cards} cards.
      -------------------------------------------------
    INTRO
  end

  def review_cards
    display_card_progress
    display_current_question
    answer_question
    display_question_feedback
  end

  def game_over_and_stats
    display_game_over
    display_round_stats
    display_category_stats
  end

  def turns_completed?
    @round.turns.size == @round.total_deck_cards
  end

  def display_card_progress
    puts "This is card number #{@round.current_card_pos} out of #{@round.total_deck_cards}."
  end

  def display_current_question
    puts @round.current_card.question
  end

  def answer_question
    @round.take_turn(gets.chomp)
  end

  def display_question_feedback
    puts @round.last_question_feedback
  end

  def display_game_over
    puts '****** Game over! ******'
  end

  def display_round_stats
    puts "You had #{@round.number_correct} correct guesses out of #{@round.total_deck_cards} for a total score of #{@round.percent_correct}%."
  end

  def display_category_stats
    # move logic to round?
    categories = @round.turns.map(&:card_category).uniq
    categories.each do |category|
      percent_correct = @round.percent_correct_by_category(category)
      puts "#{category} - #{percent_correct}% correct"
    end
  end
end

FlashCardSession.new.start

# Todo
# Check all classes for public methods that should be private.

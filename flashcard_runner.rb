# frozen_string_literal: true

require_relative 'lib/card'
require_relative 'lib/deck'
require_relative 'lib/turn'
require_relative 'lib/round'

class FlashCardSession
  def start
    display_intro_message

    loop do
      break if turns_completed?

      display_card_progress
      display_current_question
      answer_question
      display_question_feedback
    end

    display_game_over
    display_round_stats
    display_category_stats
  end

  private

  def initialize
    card1 = Card.new('What is the capital of Alaska?', 'Juneau', :Geography)
    card2 = Card.new('The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?', 'Mars', :STEM)
    card3 = Card.new('Describe in words the exact direction that is 697.5° clockwise from due north?', 'North north west', :STEM)
    cards = [card1, card2, card3]
    @deck = Deck.new(cards)
    @round = Round.new(@deck)
  end

  def display_intro_message
    puts <<~INTRO
      Welcome! You're playing with #{@deck.count} cards.
      -------------------------------------------------
    INTRO
  end

  def turns_completed?
    @round.turns.size == @deck.count
  end

  def display_card_progress
    # Refactor @round.turns.size + 1?
    puts "This is card number #{@round.turns.size + 1} out of #{@deck.count}."
  end

  def display_current_question
    puts @round.current_card.question
  end

  def answer_question
    @round.take_turn(gets.chomp)
  end

  def display_question_feedback
    # Refactor line below?
    puts @round.turns.last.feedback
  end

  def display_game_over
    puts '****** Game over! ******'
  end

  def display_round_stats
    # move logic to round?
    puts "You had #{@round.number_correct} correct guesses out of #{@deck.count} for a total score of #{@round.percent_correct}%."
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

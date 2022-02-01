# frozen_string_literal: true

require_relative 'card'

class Turn
  attr_reader :guess, :card

  def initialize(string, card)
    @guess = string
    @card = card
  end

  def correct?
    @guess == card.answer
  end

  def feedback
    correct? ? 'Correct!' : 'Incorrect'
  end
end

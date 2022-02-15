# frozen_string_literal: true

require 'csv'
require_relative 'card'

class CardConverter
  def self.create_cards(path)
    table = CSV.read(path, headers: true)

    table.each_with_object([]) do |row, cards|
      question = row[0]
      answer = row['answer']
      category = row['category']

      cards << Card.new(question, answer, category)
    end
  end
end

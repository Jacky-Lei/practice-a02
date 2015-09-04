require_relative 'card'

# Represents a deck of playing cards.
class Deck
  # Returns an array of all 52 playing cards.
  def self.all_cards
    starting_cards = []
    Card.suits.each do |suit|
      Card.values.each do |value|
        starting_cards << Card.new(suit, value)
      end
    end
    starting_cards
  end

  def initialize(cards = Deck.all_cards)
    @cards ||= cards
  end

  # Returns the number of cards in the deck.
  def count
    @cards.count
  end

  # Takes `n` cards from the top of the deck.
  def take(n)
    if n > @cards.length
      raise "not enough cards"
    end
    result = []
    n.times do
      result << @cards.shift #doesn't work with take?
    end
    result
  end

  # Returns an array of cards to the bottom of the deck.
  def return(cards)
    @cards.concat(cards)
  end
end

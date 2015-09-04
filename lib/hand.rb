class Hand
  # This is called a *factory method*; it's a *class method* that
  # takes the a `Deck` and creates and returns a `Hand`
  # object. This is in contrast to the `#initialize` method that
  # expects an `Array` of cards to hold.
  def self.deal_from(deck)
    Hand.new(deck.take(2))
  end

  attr_accessor :cards

  def initialize(cards)
    @cards = cards
  end

  def points
    # sum1 = @cards.inject(0) do |accum, card|
    #   if card.value == :ace && @cards.length <= 2
    #     accum + 11
    #   elsif card.value == :ace && @cards.length > 2
    #     accum + 1
    #   else
    #     accum + card.blackjack_value
    #   end
    # end
    # need to set accum as 0 or card, which is nil, will be used as accum

    normal_cards = @cards.reject {|card| card.value == :ace}
    total_points = normal_cards.inject(0) {|accum, card| accum + card.blackjack_value}
    aces = @cards.select {|card| card.value == :ace} # cards - normal_cards
    total_points += aces.length
    aces.each do |ace|
      total_points += 10 unless total_points > 11
    end
    total_points
  end

  def busted?
    self.points > 21
  end

  def hit(deck)
    raise "already busted" if busted?
    @cards.concat(deck.take(1)) #why not << ?
  end

  def beats?(other_hand)
    return false if busted?
    return true if other_hand.busted?
    case self.points <=> other_hand.points
    when 1 then true
    when -1 then false
    when 0 then false # points > other_hand.points
    end
  end

  def return_cards(deck)
    deck.return(@cards)
    @cards.pop until @cards.empty? #@cards = []
  end

  def to_s
    @cards.join(",") + " (#{points})"
  end
end

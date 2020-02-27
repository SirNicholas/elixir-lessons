defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck" do
    deck_length = length(Cards.create_deck())
    assert deck_length == 28
  end

  test "shuffle" do
    deck = Cards.create_deck
    refute deck == Cards.shuffle(deck)
  end
end

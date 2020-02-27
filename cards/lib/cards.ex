defmodule Cards do
  @moduledoc """
    Test doc
  """

  @doc """
    Returns deck
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for value <- values, suit <- suits do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Check if card is present

    ## Examples:

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    `hand_size` is the number of cards in the results together with the `deck` that left

    ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save_deck(deck, file_name) do
    binary = :erlang.term_to_binary(deck)
    File.write(file_name, binary)
  end

  def load_deck(file_name) do
    # Bad approach
    {status, content} = File.read(file_name)

    case status do
      :ok -> :erlang.binary_to_term(content)
      :error -> "File is not exist"
      # _ -> "Other error"
    end

    # Good approach
    case File.read(file_name) do
      {:ok, content} -> :erlang.binary_to_term(content)
      {:error, reason} -> "An error occured, reason: #{reason}"
    end
  end

  def create_hand(hand_size) do
    create_deck()
    |> shuffle()
    |> deal(hand_size)
  end
end

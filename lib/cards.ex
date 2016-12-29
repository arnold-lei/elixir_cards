defmodule Cards do
    @moduledoc """
        Provides methods for creating and handling a deck of cards
    """


    @doc """
        Generates a list of strings that represent a deck of cards
    """
    def create_deck do
        values  = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
        suits   = ["Diamonds", "Clubs", "Hearts", "Spades"]
        for suit <- suits, value <- values do
            "#{value} of #{suit}"
        end
    end

    def shuffle(deck) do
        Enum.shuffle(deck)
    end
    @doc """
        
    """
    def contains?(deck, card) do
        Enum.member?(deck, card)
    end


    @doc """
        Deals out a hand with the creted deck. `hand_size` limits the number of cards dealt.

    ## Examples

        iex> deck = Cards.create_deck
        iex> {hand, deck} = Cards.deal(deck, 1)
        iex> hand
        ["Ace of Diamonds"]

    """
    def deal(deck, hand_size) do
        Enum.split(deck, hand_size)
    end

    def save(deck, filename) do
        binary = :erlang.term_to_binary(deck)
        File.write(filename, binary)
    end

    def load(filename) do
        {status, _binary} = File.read(filename)
        case status do
            {:ok, binary}       -> :erlang.binary_to_term(binary)
            {:error, _reason}    -> "That file does not exist"
        end
    end

    def create_hand(hand_size) do
        Cards.create_deck |> Cards.shuffle |> Cards.deal(hand_size)
    end
end

defmodule Identicon do
  require Integer

  def main(string) do
    IEx.configure(inspect: [charlists: :as_lists]) # TODO: figure out how to manage this in project configs
    string
    |> hash_string
    |> pick_color
    |> build_grid
    |> filter_odd_squares
  end

  def hash_string(string) do
    hex = :crypto.hash(:md5, string) |> :binary.bin_to_list
    %Identicon.Image{ hex: hex }
  end

  def pick_color(%Identicon.Image{ hex: [r, g, b | _] } = image) do
    # Enum.take(image.hex, 3)
    %Identicon.Image{ image | color: [r, g, b] }
  end

  def build_grid(%Identicon.Image{ hex: hex } = image) do
    grid =
      hex
      |> List.delete_at(-1)
      |> Enum.chunk_every(3)
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index
    %Identicon.Image{ image | grid: grid }
  end

  def filter_odd_squares(%Identicon.Image{ grid: grid } = image) do
    new_grid = Enum.filter grid, fn({ value, _ }) ->
      Integer.is_even(value)
    end
    %Identicon.Image{ image | grid: new_grid }
  end

  def mirror_row(row) do
    [first, second | _] = row
    row ++ [second, first]
  end
end

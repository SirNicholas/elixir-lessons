defmodule Identicon do
  def main(string) do
    IEx.configure(inspect: [charlists: :as_lists]) # TODO: figure out how to manage this in project configs
    string
    |> hash_string
    |> pick_color
    |> build_grid
  end

  def hash_string(string) do
    hex = :crypto.hash(:md5, string) |> :binary.bin_to_list
    %Identicon.Image{ hex: hex }
  end

  def pick_color(%Identicon.Image{ hex: [r, g, b | _tail] } = image) do
    # Enum.take(image.hex, 3)
    %Identicon.Image{ image | color: [r, g, b] }
  end

  def build_grid(%Identicon.Image{ hex: hex } = image) do
    new_hex = hex
    |> List.delete_at(-1)
    |> Enum.chunk_every(3)
    %Identicon.Image{ image | hex: new_hex }
  end

  def mirror_row(row) do

  end
end

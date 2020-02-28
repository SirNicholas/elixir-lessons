defmodule Identicon do
  def main(string) do
    string
    |> hash_string
  end

  def hash_string(string) do
    :crypto.hash(:md5, string)
    |> :binary.bin_to_list
  end
end

defmodule Identicon do
  @moduledoc """
    Provides methods for creating a unique identicon based on the user's name.
  """

  @moduledoc """
    Accepts an input and passes it through the sequence of functions to generate and identicon based on the user input.
  """
  def main(input) do
    input
    |> hash_input
    |> pick_color
  end

  @moduledoc """
    Accepts the hex struct and returns the first three indices as an RGB value.
  """
  def pick_color(image) do
    %Identicon.Image{hex: hex_list} = image
    [r, g, b | _tail] = hex_list

    [r, g, b]
  end

  @moduledoc """
    Generates a unique list of numbers based on an input, and calls Indenticon.Image to return it as a struct.
  """
  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end
end

# iex -S mix to start the shell
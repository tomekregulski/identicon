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
    |> build_grid
    |> filter_odd_squares
  end


  @moduledoc """
    Filter out odd squares so they do not get colored.
  """
  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    grid = Enum.filter grid, fn({code, _index}) -> 
      rem(code, 2) == 0
    end

    %Identicon.Image{image | grid: grid}
  end

  @moduledoc """
    Builds the image grid and maps it with a reference to the helper function mirror_row
  """
  def build_grid(%Identicon.Image{hex: hex} = image) do
    grid = 
      hex
      |> Enum.chunk(3)
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index

    %Identicon.Image{image | grid: grid}
  end

  @moduledoc """
    Accepts the RGB value for each row and expands it into a palindrome
  """
  def mirror_row(row) do
    [first, second | _tail] = row
    row ++ [second, first]
  end

  @moduledoc """
    Accepts the hex struct and returns the first three indices as an RGB value, and the rest of the struct as a tail.
  """
  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
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
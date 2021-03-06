defmodule Identicon do
  @moduledoc """
    Provides methods for creating a unique identicon based on the user's input.
  """

  @doc """
    Accepts an input and passes it through the sequence of functions to generate the identicon.
  """
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
    |> draw_image
    |> save_image(input)
  end

  @doc """
    Saves the Identicon to a png file that is named after the user's input.
  """
  def save_image(image, input) do
    File.write("#{input}.png", image)
  end

  @doc """
    Renders the identicon.
  """
  def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)

    Enum.each pixel_map, fn({start, stop}) ->
      :egd.filledRectangle(image, start, stop, fill)
    end

    :egd.render(image)
  end

  @doc """
    Builds the pixel map, over which the Identicon will be rendered
  """
  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel_map = Enum.map grid, fn({_code, index}) ->
      horizontal = rem(index, 5) * 50
      vertical = div(index, 5) * 50
      top_left = {horizontal, vertical}
      bottom_right = {horizontal + 50, vertical + 50}

      {top_left, bottom_right}
    end

    %Identicon.Image{image | pixel_map: pixel_map}
  end


  @doc """
    Filters out odd squares so they do not get colored.
  """
  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    grid = Enum.filter grid, fn({code, _index}) -> 
      rem(code, 2) == 0
    end

    %Identicon.Image{image | grid: grid}
  end

  @doc """
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

  @doc """
    Accepts the RGB value for each row and expands it into a palindrome
  """
  def mirror_row(row) do
    [first, second | _tail] = row
    row ++ [second, first]
  end

  @doc """
    Accepts the hex struct and returns the first three indices as an RGB value, and the rest of the struct as a tail.
  """
  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end

  @doc """
    Generates a unique list of numbers based on an input, and calls Indenticon.Image to return it as a struct.
  """
  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end
end

# iex -S mix to start the shell
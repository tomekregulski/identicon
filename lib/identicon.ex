defmodule Identicon do
  @moduledoc """
    Provides methods for creating a unique identicon based on the user's name.
  """

  @moduledoc """
    Accempts an input and passes it to the hash_input function
  """
  def main(input) do
    input
    |> hash_input
  end

  @moduledoc """
    Generates a unique list of numbers based on an input
  """
  def hash_input(input) do
    :crypto.hash(:md5, input)
    |> :binary.bin_to_list
  end
end

# iex -S mix to start the shell
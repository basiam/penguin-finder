defmodule PenguinFinderTest do
  use ExUnit.Case, async: true
  doctest PenguinFinder

  @index_file "secrets/CRNCLHYEMR.txt"

  test "find the index file in a directory" do
    assert PenguinFinder.find_index("secrets") == @index_file
  end

  test "return null if no index file available" do
    assert PenguinFinder.find_index("worngs") == nil
  end

  test "extracts data from index file" do
    data = PenguinFinder.extract_data(@index_file)
    assert List.first(data) ==
      PenguinFinder.penguin(name: "Skipper", rank: "Leader")
  end
end

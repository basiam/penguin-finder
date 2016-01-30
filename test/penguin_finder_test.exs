defmodule PenguinFinderTest do
  use ExUnit.Case
  doctest PenguinFinder

  test "find the index file in a directory" do
    assert PenguinFinder.find_index("secrets") == "secrets/CRNCLHYEMR.txt"
  end

  test "return null if no index file available" do
    assert PenguinFinder.find_index("worngs") == nil
  end
end

defmodule PenguinFinder do
  @doc """
  Find index file
  """
  def find_index(directory) do
    files = Path.wildcard(Path.join(directory, "*.txt"))
    Enum.find files, &(is_index?(&1))
  end

  defp is_index?(file) do
    File.open! file, fn(pid) ->
      IO.read(pid, 15) == "Mission members"
    end
  end
end

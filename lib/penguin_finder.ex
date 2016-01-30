defmodule PenguinFinder do
  require Record

  Record.defrecord :penguin, [name: nil, rank: nil]

  @doc """
  Find index file in given directory

  ## Examples
      iex> PenguinFinder.find_index("adasdasdasd")
      nil
  """
  def find_index(directory) do
    files = Path.wildcard(Path.join(directory, "*.txt"))
    Enum.find files, &(is_index?(&1))
  end

  def extract_data(index_file) do
    File.open! index_file, fn(pid) ->
      IO.read(pid, :line)
      extract_info(pid, [])
    end
  end

  defp extract_info(pid, acc) do
    case IO.read(pid, :line) do
      :eof -> Enum.reverse(acc)
      info when is_binary(info) ->
        path = IO.read(pid, :line)
        extract_info(pid, info, path, acc)
    end
  end

  defp extract_info(pid, info, path, acc) do
    [name, rank] = String.split(info, "; ")
    record = penguin(name: String.strip(name), rank: String.strip(rank))
    extract_info(pid, [record|acc])
  end

  defp is_index?(file) do
    File.open! file, fn(pid) ->
      IO.read(pid, 15) == "Mission members"
    end
  end
end

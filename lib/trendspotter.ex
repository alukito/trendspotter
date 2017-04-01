defmodule Trendspotter do
 
  def get_consecutive_highs(arr, n) do
    get_consecutive_by(
      {
        arr,
        n,
        fn (arr) ->
          Enum.max_by(arr, fn ({val, _}) -> val end)
        end
      },
      [])
  end

  def get_consecutive_lows(arr, n) do
    get_consecutive_by(
      {
        arr,
        n,
        fn (arr) ->
          Enum.min_by(arr, fn ({val, _}) -> val end)
        end
      },
      [])
  end

  defp get_consecutive_by({_, 0, _}, _) do
    []
  end

  defp get_consecutive_by({[], _, _}, acc) do
    acc |> Enum.reverse
  end

  defp get_consecutive_by({arr, n, fold_func} = params, acc) do
    case max_for_consecutive(params) do
      {result, processed} ->
        get_consecutive_by({Enum.drop(arr, processed), n, fold_func}, [result | acc])
      _ ->
        get_consecutive_by({[], n, fold_func}, acc)
    end
  end

  defp max_for_consecutive(params) do
    max_for_consecutive(params, 0, 0)
  end

  defp max_for_consecutive({arr, n, fold_func} = params, start, processed) do
    result =
      arr
      |> slice_exact(start, n)
      |> fold_with_index(fold_func)

    case result do
      {val, 0} -> {val, processed + n}
      {_, index} -> max_for_consecutive(params, index, processed + index)
      _ -> []
    end
  end

  defp slice_exact(arr, index, n) do
    result = Enum.slice(arr, index, n)
    case Enum.count(result) do
      ^n -> result
      _ -> []
    end
  end

  defp fold_with_index([], _), do: []

  defp fold_with_index(arr, fold_func) do
    fold_func.(arr |> Enum.with_index)
  end
end

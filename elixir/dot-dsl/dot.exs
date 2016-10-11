defmodule Graph do
  defstruct attrs: [], nodes: [], edges: []
end

defmodule Dot do

  defmacro graph(do: ast) do
    ast
    |> process(%Graph{})
    |> Macro.escape
  end

  defp process(nil, graph), do: graph

  defp process({:__block__, _, children}, graph) do
    children
    |> Enum.reduce(graph, fn(child,graph) -> process(child,graph) end)
  end

  defp process({:graph, _, [[]]}, graph), do: graph

  defp process({:graph, _, [[attrs]]}, graph) do
    Map.update(graph, :attrs, [], fn(acc) -> Enum.sort([attrs|acc]) end)
  end

  defp process({:--, _, [{edge1, _, _}, {edge2, _, nil}]}, graph) do
    update_edges(graph, edge1, edge2, [])
  end

  defp process({:--, _, [{edge1, _, _}, {edge2, _, [[]]}]}, graph) do
    update_edges(graph, edge1, edge2, [])
  end

  defp process({:--, _, [{edge1, _, _}, {edge2, _, [[attrs]]}]}, graph) do
    update_edges(graph, edge1, edge2, [attrs])
  end

  defp process({node, _, nil}, graph), do: update_nodes(graph, node, [])
  defp process({node, _, [[]]}, graph), do: update_nodes(graph, node, [])
  defp process({node, _, [[attrs]]}, graph), do: update_nodes(graph, node, [attrs])

  defp process(_, _), do: raise ArgumentError

  defp update_edges(graph, edge1, edge2, attrs) do
    Map.update(graph, :edges, [], fn(acc) -> Enum.sort [{edge1, edge2, attrs}|acc] end)
  end

  defp update_nodes(graph, node, attrs) do
    Map.update(graph, :nodes, [], fn(acc) -> Enum.sort [{node,attrs}|acc] end)
  end

end

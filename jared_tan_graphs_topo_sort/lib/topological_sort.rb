require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  queue = []
  in_edge_count = {}
  vertices.each do |vertex|
     in_edge_count[vertex] = vertex.in_edges.length
    if vertex.in_edges.empty?

      queue << vertex
    end
  end

  sorted = []
  until queue.empty?
    current = queue.shift
    sorted << current
    current.out_edges.each do |edge|
      in_edge_count[edge.to_vertex] -= 1
      queue << edge.to_vertex if in_edge_count[edge.to_vertex] == 0
    end
  end
  return [] if in_edge_count.values.any? { |count| count != 0  }
  sorted
end

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


def topological_sort(vertices)
  sorted = []
  explored = Set.new
  vertices.each do |vertex|
    dfs!(vertex, sorted, explored) unless explored.include?(vertex)
  end
end

def dfs!(vertex, sorted, explored)
  explored.push(vertex)
  vertex.out_edges.each do |edge|
    new_vertex = edge.new_vertex
    dfs!(new_vertex, sorted, explored) unless explored.include?(new_vertex)
  end
  sorted.unshift(vertex)
end

def shortest_dist(start, last) #dijkstra's
  p_queue = [start]
  v_hash = {start => 0}
  while !p_queue.empty?
    current_vertex = p_queue.shift
    current_vertex.out_edges.each do |edge|
      new_vertex = edge.to_vertex
      p_queue.push(new_vertex)
      p_queue.heapify_up
      if !v_hash[new_vertex] || v_hash[new_vertex] < v_hash[current_vertex] + edge.weight
        v_hash[new_vertex] = edge.weight
        new_vertex.prev = current_vertex
      end
    end
  end

  fastest_path = []
  current_vertex2 = last
  while current_vertex2.prev
    fastest_path.unshift(current_vertex2)
    current_vertex2 = current_vertex2.prev
  end
  return fastest_path
end

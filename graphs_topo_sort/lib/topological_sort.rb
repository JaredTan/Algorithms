require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  queue = []
  in_edge_count = {}
  # Set in edge counts in a hash, and add all vertices with no in edges to the queue.
  vertices.each do |vertex|
     in_edge_count[vertex] = vertex.in_edges.length
    if vertex.in_edges.empty?
      queue << vertex
    end
  end
  sorted = []
  # Add items until the queue is empty
  until queue.empty?
    current = queue.shift
    sorted << current
    current.out_edges.each do |edge|
      in_edge_count[edge.to_vertex] -= 1
      # return [] if there are any cycles (we went passed the initial in-edge counts)
      return [] if in_edge_count[edge.to_vertex] < 0
      queue << edge.to_vertex if in_edge_count[edge.to_vertex] == 0
    end
  end
  # return [] if any disconnected vertices
  return [] if in_edge_count.values.any?{ |count| count != 0 }
  sorted
end

class TarjansTopoSort
  def initialize
    @temp_cycle_check_hash = {}
    @explored_hash = {}
    @result = []
    @cycle = false
  end

  def topo_sort(vertices)
    vertices.each do |vertex|
      # We'll depth first search through the vertex, and if we
      # find a vertex that we've already been through -
      # set @cycle to be true and return []
      @cycle = dfs!(vertex) if !@explored_hash[vertex]
      return [] if @cycle
    end

    @result
  end

  def dfs!(vertex)
    # If there is in the cycle check hash - there's a cycle
    return true if @temp_cycle_check_hash[vertex]
    @temp_cycle_check_hash[vertex] = true
    vertex.out_edges.each do |edge|
      next_vertex = edge.to_vertex
      @cycle = dfs!(next_vertex)
      return [] if @cycle
    end
    @explored_hash[vertex] = true
    # reset the vertex to be false as it is
    # now out of the depth first search path
    @temp_cycle_check_hash[vertex] = false
    @result.unshift(vertex)
    # we made it through! no cycle in that dfs.
    false
  end

end



# def shortest_dist(start, last) #dijkstra's
#   p_queue = [start]
#   v_hash = {start => 0}
#   while !p_queue.empty?
#     current_vertex = p_queue.shift
#     current_vertex.out_edges.each do |edge|
#       new_vertex = edge.to_vertex
#       p_queue.push(new_vertex)
#       p_queue.heapify_up
#       if !v_hash[new_vertex] || (v_hash[new_vertex] < v_hash[current_vertex] + edge.weight)
#         v_hash[new_vertex] = edge.weight
#         new_vertex.prev = current_vertex
#       end
#     end
#   end
#
#   fastest_path = []
#   current_vertex2 = last
#   while current_vertex2.prev
#     fastest_path.unshift(current_vertex2)
#     current_vertex2 = current_vertex2.prev
#   end
#   return fastest_path
# end

# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to

require_relative 'graph'
require_relative 'topological_sort'

def install_order(arr)
  max = 0
  vertices = {}
  arr.each do |tuple|
    # create the graph
    vertices[tuple[0]] = Vertex.new(tuple[0]) unless vertices[tuple[0]]
    vertices[tuple[1]] = Vertex.new(tuple[1]) unless vertices[tuple[1]]
    Edge.new(vertices[tuple[1]], vertices[tuple[0]])

    #reset max if needed
    max = tuple.max if tuple.max > max
  end


  # find the missing packages
  independent = []
  (1..max).each do |i|
    independent << i unless vertices[i]
  end

  # sort the vertices of the graph and add the missing packages
  independent + topological_sort(vertices.values).map { |v| v.value }
end

def install_order(arr)
  vertices = []
  vertex_hash = {}
  arr.each do |packages|
    packages.each do |package_id|
      # Create all the vertices, if they weren't aleady created
      vertex_hash[package_id] ||= Vertex.new(package_id)
    end
  end

  # create our vertices array
  vertex_hash.values.each do |vertex|
    vertices.push(vertex)
  end

  arr.each do |tuple|
    to_vertex = vertex_hash[tuple[0]]
    from_vertex = vertex_hash[tuple[1]]
    Edge.new(from_vertex, to_vertex)
  end

  topological_sort(vertices).map {|vertex| vertex.value}
end

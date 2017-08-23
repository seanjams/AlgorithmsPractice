require_relative 'graph'
require 'byebug'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  new_vertices = vertices.dup
  queue = []
  result = []

  prc = Proc.new do |arr|
    arr.select! do |vertex|
      queue << vertex if vertex.in_edges.empty?
      !vertex.in_edges.empty?
    end
  end
  prc.call(new_vertices)

  while queue.length > 0
    until queue.empty?
      result << queue.shift
      out_edges = result[-1].out_edges
      while result[-1].out_edges.length > 0
        edge = result[-1].out_edges.pop
        edge.destroy!
      end
    end
    prc.call(new_vertices)
  end

  result.length == vertices.length ? result : []
end

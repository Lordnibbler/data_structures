require 'pry'

module BinaryTree
  class Node
    attr_accessor :value, :count, :left, :right

    include Enumerable

    # create a new node
    def initialize(value)
      @value, @count = value, 1
    end

    # counts size of tree starting with `self` node
    def size
      size  = 1
      size += @left.size  unless @left.nil?
      size += @right.size unless @right.nil?
      size
    end

    # insert a node into the tree
    def insert(node)
      case @value <=> node.value
        when 1
          # alphabetically greater than, insert to left
          insert_into(:left, node)
        when 0
          # same value, so increase count of `self` node
          @count += 1
        when -1
          # alphabetically less than, insert to right
          insert_into(:right, node)
      end
    end

    def each
      # yield all nodes to left
      @left.each  { |node| yield node } unless @left.nil?

      # yield self, in center
      yield self

      # yield all nodes to right
      @right.each { |node| yield node } unless @right.nil?
    end

    # counts all unique values
    def values
      entries.map {|e| e.value }
    end

    # counts total number of nodes in tree
    def count_all
      # map all nodes into enumerable
      # then add them all together  (reduce :+)
      self.map { |node| node.count }.reduce(:+)
    end

  protected

    # insert a node into a specific destination in the tree
    def insert_into(destination, node)
      var = destination.to_s

      eval(%Q{
        if @#{var}.nil?
          # not trying to insert into left or right
          @#{var} = node
        else
          # insert into left or right
          @#{var}.insert(node)
        end
      })
    end
  end
end

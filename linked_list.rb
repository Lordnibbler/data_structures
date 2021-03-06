class Node
  attr_accessor :value, :next

  def initialize(value=nil)
    if !value.nil?
      @value = value
    else
      raise "You must provide a value for the node."
    end
  end
end

class SinglyLinkedList
  attr_accessor :head, :tail

  def initialize(first=nil)
    if first && first.class == Node
      @head = first
    else
      raise "Your must provide a first node for the list"
    end
  end

  def add(value)
    if @head.nil?
      # first node, so set it to @head
      @head = Node.new(value)
    else
      # save pointer to @head
      current_node = @head

      # loop over current_node.next until reaching end of list
      # end of list means current_node has no next
      current_node = current_node.next while current_node.next

      # instantiate a new Node, and set it to the last node's next
      current_node.next = Node.new(value)
    end
  end

  def find(value)
    # start at head
    current_node = @head

    while !current_node.nil?
      # check if value matches current node
      return current_node if current_node.value == value

      # otherwise continue walking the list
      current_node = current_node.next
    end
  end

  def remove(value)
    if @head.value == value
      # @head is the node we're removing
      # point @head to second node
      @head = @head.next
    else
      # save references to current and previous nodes
      # so we can delete and re-link
      current_node  = @head.next
      previous_node = @head

      while current_node
        if current_node.value == value
          # remove the node, and re-link
          previous_node.next = current_node.next

          # exit the loop, return success
          return true
        end
        previous_node = current_node
        current_node  = current_node.next
      end

      # return nil if value is never found
      nil
    end
  end
end

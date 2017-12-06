module BinaryTree
  class Node
    # our three features:
    attr_reader :value
    attr_accessor :left, :right

    def initialize(v)
      @value = v
      @left  = EmptyNode.new
      @right = EmptyNode.new
    end

    def to_a
      left.to_a + [value] + right.to_a
    end

    def insert(v)
      case value <=> v
      when 1 then insert_left(v)
      when -1 then insert_right(v)
      when 0 then false # the value is already present
      end
    end

    def inspect
      "{#{value}::#{left.inspect}|#{right.inspect}}"
    end

    # named include? to parallel Array#include?
    def include?(v)
      case value <=> v
      when 1 then left.include?(v)
      when -1 then right.include?(v)
      when 0 then true # the current node is equal to the value
      end
    end

    private

      def insert_left(v)
        left.insert(v) or self.left = Node.new(v)
      end

      def insert_right(v)
        right.insert(v) or self.right = Node.new(v)
      end
  end

  class EmptyNode

    def include?(*)
      false
    end

    def to_a
      []
    end

    def insert(*)
      false
    end

    def inspect
      "{}"
    end
  end

  def self.from_array(array)
    Node.new(array.first).tap do |tree|
      array.each {|v| tree.insert v }
    end
  end
end

tree       = BinaryTree::Node.new(10)
array_of_nums = (0..20).to_a.shuffle
array_of_nums = [51, 88, 62, 68, 98, 93, 51, 67, 91, 4, 34]
tree = BinaryTree.from_array(array_of_nums)
puts tree.inspect

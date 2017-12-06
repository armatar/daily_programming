require 'byebug'

class Node
  attr_accessor :value, :left, :right, :name

  def initialize(options={})
    @value = options[:value]
    @name = options[:name]
  end

  def children
    [@left, @right].compact
  end

  def children?
    @left && @right
  end

  def no_children?
    !children?
  end
end

class BinaryTree

  def initialize(value, name)
    @root_node = Node.new({value: value, name: name})
  end

  def create_binary_tree(size)
    array_of_nums = (0..size).to_a.shuffle
    new_tree = BinaryTree.new
    array_of_nums.each do |num|
      new_tree.insert(num)
    end
    return new_tree
  end
end

root = Node.new({:value => 1, :name => 'root'})
child_1 = Node.new({:value => 2, :name => 'child_1'})
child_2 = Node.new({:value => 3, :name => 'child_2'})
grand_child_1 = Node.new({:value => 4, :name => 'grand_child_1'})
grand_grand_child_1 = Node.new({:value => 5, :name => 'grand_grand_child_1'})
grand_child_1.left = grand_grand_child_1
child_1.left = grand_child_1
root.left = child_1
root.right = child_2

puts root.left.left.value
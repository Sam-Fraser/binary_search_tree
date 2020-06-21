class Node
  include Comparable
  attr_reader :data
  attr_accessor :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def <=>(other_node)
    @data <=> other_node.data
  end

  def has_children?
    return false if left.nil? && right.nil?
    true
  end

  def remove_left
    @left = nil
  end

  def remove_right
    @right = nil
  end
end

class Tree
  attr_reader :root, :arr

  def initialize(arr)
    @arr = arr.sort.uniq
    @root = build_tree(@arr)
  end

  def build_tree(arr)
    return if arr.empty?
    center = arr.length/2
    node = Node.new(arr[center])
    node.left = build_tree(arr[0...center])
    node.right = build_tree(arr[center + 1..-1])
    node
  end

  def insert(data, node = @root)
    
    case node.data <=> data
    when 1
      node.left ? insert(data, node.left) : node.left = Node.new(data)
    when 0
      return "Error: duplicate value found"
    when -1
      node.right ? insert(data, node.right) : node.right = Node.new(data)
    end
  end

  def find(data, node = @root)
    return nil if node.nil?
    case node.data <=> data
    when 1
      find(data, node.left)
    when 0
      return node
    when -1
      find(data, node.right)
    end
  end

  def find_parent(data, node = @root)
    if node.left.nil? && node.right.nil?
      nil
    elsif node.left.nil? || node.data <= data
      node.right.data == data ? node : find_parent(data, node.right)
    elsif node.right.nil? || node.data >= data
      node.left.data == data ? node : find_parent(data, node.left)
    end
  end

  def delete(data)
    node = find(data)
    parent_node = find_parent(data)
    unless node.nil?
      remove(node, parent_node)
    end
  end

  def remove(node, parent_node)
    if parent_node.left.nil? && node.has_children?

    elsif parent_node.right.nil?

    end

    if node.left.nil? && node.right.nil?
      node = nil
    elsif node.left.nil?
      node = node.right
    elsif node.right.nil?
      node = node.left
    else
      delete_with_children(node)
    end
  end

  def delete_with_children(node)
    
  end

  

end

t = Tree.new([1,5,2,4,7,3,8,9,4,0,6])
t.insert(10)
t.delete(10)
puts t.find(9)
puts t.find_parent(10)

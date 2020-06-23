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
      new_node = delete_with_children(node)
      parent_node.right = new_node
      node = nil
    elsif parent_node.right.nil? && node.has_children?
      new_node = delete_with_children(node)
      parent_node.left = new_node
      node = nil
    elsif node.has_children?
      new_node = delete_with_children(node)
      parent_node.left == node ? parent_node.left = new_node : parent_node.right = new_node
      node = nil
    elsif parent_node.left.nil?
      node = nil
      parent_node.right = node
    elsif parent_node.right.nil?
      node = nil
      parent_node.left = node
    else
      parent_node.left == node ? parent_node.left = nil : parent_node.right = nil
      node = nil
    end
  end

  def delete_with_children(node)
    new_node = nil
    if node.right.nil?
      new_node = node.left
    elsif node.left.nil?
      new_node = node.right
    else
      min = find_min(node.right)
      delete(min)
      new_node = Node.new(min)
      new_node.left = node.left
      new_node.right = node.right
    end
    new_node
  end

  def find_min(node)
    if node.left.nil?
      return node.data
    else
      find_min(node.left)
    end
  end

  def level_order(&block)
    queue = [@root]
    output = []
    until queue.length == 0
      node = queue.shift
      block_given? ? yield(node) : output.push(node)
      queue.push(node.left) unless node.left.nil?
      queue.push(node.right) unless node.right.nil?
    end
    output unless block_given?
  end

  def inorder(node = @root, &block)
    output = []
    if node.nil?
      return
    end
    
    output.push(inorder(node.left, &block))
    block_given? ? yield(node) : output.push(node)
    output.push(inorder(node.right, &block))

    output.flatten.delete_if { |n| n.nil? } unless block_given?
  end
  
  def preorder(node = @root, &block)
    output = []
    if node.nil?
      return
    end
    
    block_given? ? yield(node) : output.push(node)
    output.push(preorder(node.left, &block))
    output.push(preorder(node.right, &block))

    output.flatten.delete_if { |n| n.nil? } unless block_given?
  end

  def postorder(node = @root, &block)
    output = []
    if node.nil?
      return
    end
    
    output.push(preorder(node.left, &block))
    output.push(preorder(node.right, &block))
    block_given? ? yield(node) : output.push(node)

    output.flatten.delete_if { |n| n.nil? } unless block_given?
  end

  def depth(node = @root)
    return 0 if node.nil?

    left_depth = depth(node.left)
    right_depth = depth(node.right)

    left_depth > right_depth ? left_depth + 1 : right_depth + 1
  end

  def balanced?
    left_depth = depth(@root.left)
    right_depth = depth(@root.right)

    if left_depth - right_depth > 1 || right_depth - left_depth > 1
      "The tree is unbalanced"
    else
      "The tree is balanced"
    end
  end

  def rebalance!
    output = []
    level_order { |n| output.push(n.data) }
    @root = build_tree(output.sort.uniq)
  end
end

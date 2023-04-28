# frozen_string_literal: true

require_relative 'node'

class BST
  attr_accessor :root

  def initialize(arr = nil)
    @root = build_tree(arr.sort!)
  end

  def build_tree(arr)
    return nil if arr.empty?

    mid = arr.length / 2
    root = Node.new(arr[mid])

    root.left = build_tree(arr[0...mid])
    root.right = build_tree(arr[mid + 1..arr.length - 1])
    root
  end

  def insert(val, node = root)
    return Node.new(val) unless node

    if node.data == val
      return node
    elsif val < node.data
      node.left = insert(val, node.left)
    else
      node.right = insert(val, node.right)
    end

    node
  end

  def delete(val, node = root)
    return node unless node

    if val < node.data
      node.left = delete(val, node.left)
    elsif val > node.data
      node.right = delete(val, node.right)
    else
      return node.right unless node.left
      return node.left unless node.right

      current = node
      current = current.left while current.left
      node.data = current.data
      node.right = delete(current.data, node.right)
    end
    node
  end

  def leftmost_leaf(node)
    node = node.left until node.left.nil?

    node
  end

  def level_order
    return nil unless root

    queue = [root]
    output = []
    while queue.length.positive?
      current_node = queue.shift
      output.push(block_given? ? block.call(current_node) : current_node.data)
      queue.push(current_node.left) if current_node.left
      queue.push(current_node.right) if current_node.right
    end
    output
  end

  def pre_order(node = root, output = [], &block)
    return unless node

    output.push(block_given? ? block.call(node) : node.data)
    pre_order(node.left, output, &block)
    pre_order(node.right, output, &block)

    output
  end

  def in_order(node = root, output = [], &block)
    return unless node

    in_order(node.left, output, &block)
    output.push(block_given? ? block.call(node) : node.data)
    in_order(node.right, output, &block)

    output
  end

  def post_order(node = root, output = [], &block)
    return unless node

    post_order(node.left, output, &block)
    post_order(node.right, output, &block)
    output.push(block_given? ? block.call(node) : node.data)

    output
  end

  def height(node = root)
    return 0 unless node

    [height(node.left) + 1, height(node.right) + 1].max
  end

  def depth(val)
    if !root
      return nil
    end
    depth = 0
    current_node = root
    while current_node
      depth += 1
      return depth if current_node.data == val
      current_node = current_node.left if val < current_node.data
      current_node = current_node.right if val > current_node.data
      
    end
    return nil
  end

  def balanced?
    if !root
      return true
    end
    left = height(root.left)
    right = height(root.right)
    return (left - right).abs  <= 1
  end

  def rebalance!
    @root = build_tree(in_order)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end



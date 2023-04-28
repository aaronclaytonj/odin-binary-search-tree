require_relative 'lib/tree'

tree = BST.new((Array.new(15) { rand(1..100) }))
tree.pretty_print
p tree.balanced?
p tree.pre_order
p tree.in_order
p tree.post_order
10.times do
  tree.insert(rand(1..100))
end
p tree.balanced?
tree.pretty_print
tree.rebalance!
tree.pretty_print
p tree.balanced?
p tree.pre_order
p tree.in_order
p tree.post_order

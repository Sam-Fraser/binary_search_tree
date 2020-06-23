require_relative 'main.rb'

#1. Create a binary search tree from an array of random numbers (`Array.new(15) { rand(1..100) }`)
tree = Tree.new(Array.new(15) { rand(1..100) })

#2. Confirm that the tree is balanced by calling `#balanced?`
puts tree.balanced?

#3. Print out all elements in level, pre, post, and in order
inorder = []
tree.inorder { |n| inorder.push(n.data) }
preorder = []
tree.preorder { |n| preorder.push(n.data) }
postorder = []
tree.postorder { |n| postorder.push(n.data) }
p inorder
p preorder
p postorder

#4. try to unbalance the tree by adding several numbers > 100
tree.insert(101)
tree.insert(102)
tree.insert(103)
tree.insert(104)
tree.insert(105)
tree.insert(106)
tree.insert(107)

#5. Confirm that the tree is unbalanced by calling `#balanced?`
puts tree.balanced?

#6. Balance the tree by calling `#rebalance!`
tree.rebalance!

#7. Confirm that the tree is balanced by calling `#balanced?`
puts tree.balanced?

#8. Print out all elements in level, pre, post, and in order
inorder2 = []
tree.inorder { |n| inorder2.push(n.data) }
preorder2 = []
tree.preorder { |n| preorder2.push(n.data) }
postorder2 = []
tree.postorder { |n| postorder2.push(n.data) }
p inorder2
p preorder2
p postorder2
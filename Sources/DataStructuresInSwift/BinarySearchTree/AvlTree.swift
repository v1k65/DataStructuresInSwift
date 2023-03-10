import Foundation

// MARK: - Node
public protocol iAvlTreeNode: iBinarySearchTreeNode {
	var height: Int { get set }
}

extension iAvlTreeNode {
	var balanceFactor: Int { leftChildHeight - rightChildHeight }
	var leftChildHeight: Int { leftChild?.height ?? 0 }
	var rightChildHeight: Int { rightChild?.height ?? 0 }
}

// MARK: - Tree
final public class AvlTree<NodeType: iAvlTreeNode> {
	
	public private(set) var root: NodeType? = nil
}

extension AvlTree: iBinarySearchTree {
	
	public func insert(node newNode: NodeType) {
		guard let rootNode = root else { // Setup root node
			root = newNode
			return
		}
				
		func _insert(treeNode: NodeType) {
			if newNode <= treeNode {
				guard let leftChildNode = treeNode.leftChild else {
					treeNode.leftChild = newNode
					return
				}
				_insert(treeNode: leftChildNode)
			}
			else {
				guard let rightChildNode = treeNode.rightChild else {
					treeNode.rightChild = newNode
					return
				}
				_insert(treeNode: rightChildNode)
			}
			
			treeNode.height = max(treeNode.leftChildHeight, treeNode.rightChildHeight) + 1
		}
		
		_insert(treeNode: rootNode)
	}

	public func remove(node nodeToRemove: NodeType) {
		if nodeToRemove == root {
			if let leftChild = root?.leftChild {
				let rightChild = root?.rightChild
				root = leftChild
				insert(node: rightChild)
			}
			else if let rightChild = root?.rightChild {
				root = rightChild
			}
			else {
				root = nil
			}
			return
		}
		
		func _remove(treeNode: NodeType?) -> (NodeType?, NodeType?) {
			guard let treeNode else { return (nil, nil) }
			
			if treeNode.leftChild == nodeToRemove {
				defer { treeNode.leftChild = nil }
				return (treeNode.leftChild?.leftChild, treeNode.leftChild?.rightChild)
			}
			if treeNode.rightChild == nodeToRemove {
				defer { treeNode.rightChild = nil }
				return (treeNode.rightChild?.leftChild, treeNode.rightChild?.rightChild)
			}
			
			defer {
				treeNode.height = max(treeNode.leftChildHeight, treeNode.rightChildHeight) + 1
			}
			
			return _remove(treeNode: nodeToRemove < treeNode ? treeNode.leftChild : treeNode.rightChild)
		}

		let result = _remove(treeNode: root)
		insert(node: result.0)
		insert(node: result.1)
	}
}

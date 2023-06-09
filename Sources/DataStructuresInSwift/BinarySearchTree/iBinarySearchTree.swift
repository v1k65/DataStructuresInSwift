import Foundation

// MARK: - Node
public protocol iBinarySearchTreeNode: Comparable, AnyObject {
		
	var leftChild: Self? { get set }
	var rightChild: Self? { get set }
}

// MARK: - Tree
public protocol iBinarySearchTree {
	associatedtype NodeType: iBinarySearchTreeNode
	
	var root: NodeType? { get }
	
	func contains(node: NodeType) -> Bool
	
	func insert(node: NodeType)
	func remove(node: NodeType)
}

public extension iBinarySearchTree {
	
	var isEmpty: Bool { root == nil }
	
	func contains(node: NodeType) -> Bool {
		func _contains(treeNode: NodeType?) -> Bool {
			guard let treeNode else { return false }
			if treeNode == node { return true }
			
			return _contains(treeNode: node < treeNode ? treeNode.leftChild : treeNode.rightChild)
		}
		
		return _contains(treeNode: root)
	}
}

public extension iBinarySearchTree {
	
	func insert(node: NodeType?) {
		if let node { insert(node: node) }
	}
	
	func remove(node: NodeType?) {
		if let node { remove(node: node) }
	}
}

public extension iBinarySearchTree {
	
	func mininum(of node: NodeType) -> NodeType {
		guard let leftNode = node.leftChild else {
			return node
		}
		return mininum(of: leftNode)
	}
	
	func maximun(of node: NodeType) -> NodeType {
		guard let rightChild = node.rightChild else {
			return node
		}
		return maximun(of: rightChild)
	}
}

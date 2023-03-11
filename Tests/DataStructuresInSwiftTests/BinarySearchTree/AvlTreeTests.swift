import XCTest
@testable import DataStructuresInSwift

fileprivate final class AvlTreeTestNode: iAvlTreeNode {
	let data: Int
	
	var height = 1
	var leftChild: AvlTreeTestNode? = nil
	var rightChild: AvlTreeTestNode? = nil
	
	init(_ data: Int) {
		self.data = data
	}
}

extension AvlTreeTestNode: Comparable {
	static func < (lhs: AvlTreeTestNode, rhs: AvlTreeTestNode) -> Bool {
		lhs.data < rhs.data
	}
	
	static func == (lhs: AvlTreeTestNode, rhs: AvlTreeTestNode) -> Bool {
		lhs.data == rhs.data
	}
}

// MARK: - Tests
final class AvlTreeTests: XCTestCase {
	
	func testEmpty() throws {
		let tree = AvlTree<AvlTreeTestNode>()
		XCTAssertTrue(tree.isEmpty)
		XCTAssertEqual(tree.height, 0)
		XCTAssertFalse(tree.contains(node: AvlTreeTestNode(Int.random(in: -10000...100000))))
	}
	
	func testInsertRemove() throws {
		let tree = AvlTree<AvlTreeTestNode>()
		let node33 = AvlTreeTestNode(33)
		tree.insert(node: node33)
		
		XCTAssertFalse(tree.isEmpty)
		XCTAssertEqual(tree.height, 1)
		XCTAssertTrue(tree.contains(node: node33))
		XCTAssertFalse(tree.contains(node: AvlTreeTestNode(333)))
		
		tree.remove(node: node33)
		XCTAssertTrue(tree.isEmpty)
		XCTAssertEqual(tree.height, 0)
		XCTAssertFalse(tree.contains(node: node33))
	}
	
	func testMinumunAndMaximun() {
		let node4 = AvlTreeTestNode(4)
		let node1 = AvlTreeTestNode(1)
		let node70 = AvlTreeTestNode(70)
		let node45 = AvlTreeTestNode(45)
		let node105 = AvlTreeTestNode(105)
		let node77 = AvlTreeTestNode(77)
		let node18 = AvlTreeTestNode(18)
		
		let root = AvlTreeTestNode(40)
		

		let tree: AvlTree<AvlTreeTestNode> = {
			let tree = AvlTree<AvlTreeTestNode>()
			tree.insert(node: root)
			tree.insert(node: node18)
			tree.insert(node: node77)
			tree.insert(node: node1)
			tree.insert(node: node4)
			tree.insert(node: AvlTreeTestNode(20))
			tree.insert(node: AvlTreeTestNode(25))
			tree.insert(node: node70)
			tree.insert(node: node105)
			tree.insert(node: node45)
			tree.insert(node: AvlTreeTestNode(88))
			return tree
		}()

		XCTAssertEqual(tree.height, 3)
		XCTAssertEqual(tree.mininum(of: node4), node4)
		XCTAssertEqual(tree.maximun(of: node4), node4)
		
		XCTAssertEqual(tree.mininum(of: node1), node1)
		XCTAssertEqual(tree.maximun(of: node1), node4)
		
		XCTAssertEqual(tree.mininum(of: node70), node45)
		XCTAssertEqual(tree.maximun(of: node70), node70)
		
		XCTAssertEqual(tree.mininum(of: node70), node45)
		XCTAssertEqual(tree.maximun(of: node70), node70)
		
		XCTAssertEqual(tree.mininum(of: node77), node45)
		XCTAssertEqual(tree.maximun(of: node77), node105)
		
		XCTAssertEqual(tree.mininum(of: root), node1)
		XCTAssertEqual(tree.maximun(of: root), node105)
		
//		tree.printInorder()
//		tree.remove(node: AvlTreeTestNode(20))
//		tree.remove(node: AvlTreeTestNode(1))
//		tree.remove(node: AvlTreeTestNode(77))
//		tree.remove(node: AvlTreeTestNode(88))
//		tree.remove(node: AvlTreeTestNode(40))
//		tree.remove(node: AvlTreeTestNode(25))
//		tree.remove(node: AvlTreeTestNode(105))
//		tree.remove(node: AvlTreeTestNode(4))
//		tree.remove(node: AvlTreeTestNode(70))
//		tree.remove(node: AvlTreeTestNode(18))
//		tree.remove(node: AvlTreeTestNode(45))
//
//		print()
//		tree.printInorder()
	}
}

// MARK: -
extension AvlTreeTestNode {
	
	static func printInorder(node: AvlTreeTestNode) {
		var sameHeightNodes: [AvlTreeTestNode?] = [node]
		
		var offsetSpace = Array(repeating: " ", count: 32).joined()
		var hasAnyNode = true

		while hasAnyNode {
			print(offsetSpace, terminator: "")
			hasAnyNode = false
			var nextSameHeightNodes: [AvlTreeTestNode?] = []
			for sameHeightNode in sameHeightNodes {
				if let hasSameHeightNode = sameHeightNode {
					hasAnyNode = true
					print("\(hasSameHeightNode.data),\(hasSameHeightNode.height)", terminator: "")
				}
				nextSameHeightNodes.append(sameHeightNode?.leftChild)
				nextSameHeightNodes.append(sameHeightNode?.rightChild)
				print("\(offsetSpace)\(offsetSpace)", terminator: "")
			}
			print()
			offsetSpace = Array(repeating: " ", count: offsetSpace.count / 2).joined()
			sameHeightNodes = nextSameHeightNodes
		}
	}
}

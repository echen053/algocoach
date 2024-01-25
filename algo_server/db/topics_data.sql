INSERT INTO Topic (id, name, description) VALUES
    (1, "Breadth First Search", "It's like flood fill."),
    (2, "Depth First Search", "Very useful in interview."),
    (3, "Dynamic Programming", "Excellent math skills needed.");

 INSERT INTO Concept (description, topic_id) VALUES
    ("Breadth-First Search (BFS) is a graph traversal algorithm that explores a graph level by level." ||
     "Starting from a source node, BFS visits all its neighbors before moving on to their neighbors, " ||
     "and so on. It ensures that all nodes at the current depth are visited before moving on to the " ||
     "nodes at the next depth. BFS is commonly implemented using a queue data structure.", 1),
    ("DFS explores a graph or tree by going as deep as possible down each branch before backtracking." ||
    "This is typically implemented using recursion or a stack.Backtracking is an extension of DFS." ||
    "It involves trying out all possibilities until the desired solution is found or all options have" ||
    "been exhausted. The key here is that when you determine the current path or choice does not lead to" ||
    "a solution, you 'backtrack' to the previous step and try a different option.", 2),
    ("Dynamic Programming is a powerful optimization technique used to solve problems by breaking them " ||
    "down into smaller overlapping subproblems. It involves solving each subproblem only once and storing " ||
    "its solution, avoiding redundant computations. The key idea is to store the solutions to subproblems " ||
    "in a table to avoid redundant computations when the same subproblem reoccurs.", 3);

 INSERT INTO Problem (name, url, topic_id) VALUES
    ("278. First Bad Version", "https://leetcode.com/problems/first-bad-version", 1),
    ("100. Same Tree", "https://leetcode.com/problems/same-tree", 1),
    ("104. Maximum Depth of Binary Tree", "https://leetcode.com/problems/maximum-depth-of-binary-tree", 1),
    ("94. Binary Tree Inorder Traversal", "https://leetcode.com/problems/binary-tree-inorder-traversal", 2),
    ("98. Validate Binary Search Tree", "https://leetcode.com/problems/validate-binary-search-tree", 2),
    ("112. Path Sum", "https://leetcode.com/problems/path-sum", 2),
    ("70. Climbing Stairs", "https://leetcode.com/problems/climbing-stairs", 3),
    ("118. Pascal's Triangle", "https://leetcode.com/problems/pascals-triangle", 3),
    ("120. Triangle", "https://leetcode.com/problems/triangle", 3);


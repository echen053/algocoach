INSERT INTO Topic (id, name, description) VALUES
    (1, "Breadth First Search", "It's like flood fill."),
    (2, "Depth First Search", "Very useful in interview."),
    (3, "Dynamic Programming", "Excellent math skills needed.");

 INSERT INTO Concept (description, topic_id) VALUES
    ("The concept is like flood fill.", 1),
    ("The concept is very useful in interview.", 2),
    ("The concept is solving complex problems with simpler ones.", 3);

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


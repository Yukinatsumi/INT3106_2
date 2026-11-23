
abstract sig Entry {
  parent: lone Dir
}
sig File extends Entry {}
sig Dir extends Entry {}
one sig Root extends Dir {}

fact RootHasNoParent {
  no Root.parent
}

fact NonRootHasOneParent {
  all e: Entry - Root | one e.parent
}

fact NoCycles {
  all e: Entry | e not in e.^parent
}

fact ReachRoot {
  all e: Entry | Root in e.*parent
}

fact MaxThreeDirectChildren {
  all d: Dir | #(parent.d) <= 3
}

pred FileAtDepthThree {
  some f: File | f.parent.parent.parent = Root
}

pred DirWithTwoDirectFiles {
  some d: Dir | #((parent.d) & File) = 2
}

pred SubtreeWithAtLeastThreeFiles {
  some d: Dir | #((^parent).d & File) >= 3
}

run FileAtDepthThree for 6
run DirWithTwoDirectFiles for 6
run SubtreeWithAtLeastThreeFiles for 6

run FileAtDepthThree for 8
run DirWithTwoDirectFiles for 8
run SubtreeWithAtLeastThreeFiles for 8

assert AllNonRootHaveRootAsAncestor {
  all e: Entry - Root | Root in e.^parent
}

assert AntisymmetricAncestor {
  all a, b: Entry | (a in b.^parent) implies (b not in a.^parent)
}

assert AtMostThreeDirectImpliesAtMostThreeFilesInSubtree {
  all d: Dir | (#(parent.d) <= 3) implies (#((^parent).d & File) <= 3)
}

check AllNonRootHaveRootAsAncestor for 6
check AntisymmetricAncestor for 6
check AtMostThreeDirectImpliesAtMostThreeFilesInSubtree for 6

check AllNonRootHaveRootAsAncestor for 8
check AntisymmetricAncestor for 8
check AtMostThreeDirectImpliesAtMostThreeFilesInSubtree for 8
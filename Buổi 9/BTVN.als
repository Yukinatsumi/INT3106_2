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

fact NoSelfParent {
  all d: Dir | d.parent != d
}

fact NoTwoCycle {
  all d1, d2: Dir | d1.parent = d2 implies d2.parent != d1
}

assert AllFilesHaveParent {
  all f: File | one f.parent
}

assert NoThreeCycle {
  no disj d1, d2, d3: Dir | d1.parent = d2 and d2.parent = d3 and d3.parent = d1
}

assert AllNonRootDirsHaveRootAsParent {
  all d: Dir - Root | d.parent = Root
}

check AllFilesHaveParent for 5
check NoThreeCycle for 5
check AllNonRootDirsHaveRootAsParent for 5

fact NoCyclesAtAll {
  all d: Dir | d not in d.^parent
}

check NoThreeCycle for 5
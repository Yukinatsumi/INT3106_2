sig Dept{}
sig User {
	depts: some Dept,
	reads: set Doc
}
sig Doc {
	owner: one User,
	dept: one Dept
}
assert OwnerOnlyCross {
	all u: User, d: u.reads | d.dept not in u.depts
	implies d.owner = u
}
check OwnerOnlyCross for 5

sig Author {}
sig Member {}
sig Book {
    author: some Author,
    borrowed: lone Member
}
one sig Library {
    book: set Book,
    member: set Member,
    librarian: one Member
}
pred show {}
run show for 3

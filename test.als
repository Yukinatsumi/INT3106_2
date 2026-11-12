sig Teacher {}
sig Student {
    Register: set Subject,
    Adviser: lone Teacher 
}
sig Subject {
    Teacher: one Teacher,
    Prereq: set Subject
}
pred Show {}
run Show for 3
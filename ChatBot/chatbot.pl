:- consult('about.pl').
:- consult('faculties.pl').
:- consult('departments.pl').
:- consult('degrees.pl').


% Chatbot responses
start :-
    write('Welcome to the Open University of Sri Lanka chatbot!'), nl,
    write('How can I assist you today?'), nl, nl,
    repeat,
    write('> '),
    read(Input),
    process(Input),
    (Input == exit; Input == quit), !.

process(about) :-
    write('Here are the available sections in the About page:'), nl, nl,
    forall(about(Section), (write('- '), write(Section), nl, nl)).

process(about(Section)) :-
    ( about_link(Section, Link) ->
        write('Section: '), write(Section), nl, nl,
        write(Link), nl, nl
    ;
        write('Invalid section. Please choose a valid About section.'), nl,
        write('Available sections are:'), nl,
        forall(about(S), (write('- '), write(S), nl, nl))
    ).

process(faculties) :-
    write('The university has the following faculties:'), nl,
    forall(faculty(F), (write('- '), write(F), nl, nl)).

process(faculties(F)) :-
    ( faculty_link(F, Link) ->
        write('Faculty: '), write(F), nl,
         write(Link), nl, nl
    ;
        write('Invalid faculty. Available faculties:'), nl,
        forall(faculty(F), (write('- '), write(F), nl, nl))).

process(department) :-
    write('The university has the following departments :'), nl,
    forall(department(Dept), (write('- '), write(Dept), nl, nl)).

process(department(Fac)) :-
    faculty(Fac),
    write('The departments in '), write(Fac), write(' faculty are:'), nl,
    forall(departmentof(Dept, Fac), (write('- '), write(Dept), nl, nl)).

process(department(Dept)) :-
    ( department_link(Dept, Link) ->
        write('Department: '), write(Dept), nl,
        write(Link), nl, nl
    ;
        write('Invalid department. Available departments :'), nl,
        forall(department(Dept), (write('- '), write(Dept), nl, nl))).

process(degrees) :-
    write('The university has the following departments :'), nl,
    forall(degrees(Deg), (write('- '), write(Deg), nl, nl)).

process(degrees(Dept)) :-
    department(Dept),
    write('The degree programs offered by the '), write(Dept), write(' department are:'),
nl,
    forall(degreeof(Deg, Dept), (write('- '), write(Deg), nl, nl)).

process(degrees(Deg)) :-
    ( degree_link(Deg, Link) ->
        write('Degree: '), write(Deg), nl,
        write(Link), nl, nl
    ;
        write('Invalid degree. Available degrees :'), nl,
        forall(degrees(Deg), (write('- '), write(Deg), nl, nl))).

process(exit) :-
    write('Thank you for using the chatbot. Goodbye!'), nl.

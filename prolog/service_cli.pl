:- module(service_cli, []).

:- use_module(knowledge_base, []).

:- initialization(main).

main :-
    write('=============================='), nl,
    write('WhereTo v0.1'), nl,
    write('\'Resolve your destination...\''), nl.
    write('=============================='), nl.

prompt :-
    write('Input up to 3 out of 4 of the available criteria [...'),
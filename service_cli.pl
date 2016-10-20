:- module(service_cli, []).

:- use_module(knowledge_base, []).

:- initialization(main).

main :-
    write('WhereTo v0.1'), nl,
    write('Resolve your destination...'), nl.
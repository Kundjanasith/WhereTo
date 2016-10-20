:- module(service_cli, []).

:- use_module(knowledge_base, []).

:- initialization(main).

main :-
    write('------------------------------'), nl,
    write('WhereTo v0.1'), nl,
    write('\'Resolve your destination...\''), nl,
    write('------------------------------'), nl,

    Types = [activity, month, continent, country],
    Info = [activity, month, continent, country],
    
    nl, write('Which suggestion do you need? '),

    write(Types), nl,
    read(Suggestion),

    split(Types, Suggestion, Left, Right),
    append(Left, Right, NewTypes),

%   replace(Suggestion, Suggested, Info, NewInfo),

%   write(NewInfo), nl,
%   write(NewTypes), nl,
%   write(Suggested), nl,
    
    receive(NewTypes, Info, PopulatedInfo),
    write('PopulatedInfo: '), write(PopulatedInfo), nl,

    replace(Suggestion, Suggested, PopulatedInfo, QueryInfo),
    write('QueryInfo: '), write(QueryInfo), nl.

receive([], Infos, Return) :- Return = Infos.
receive([Type|Types], Infos, Return) :-
    write('Please provide \''), write(Type), write('\' ...'),
    read(ReadIn),
    replace(Type, ReadIn, Infos, PopulatedInfo),
    receive(Types, PopulatedInfo, Return).

%    receive([activity, month, continent, country], []).

% List split.
split(List, Pivot, Left, Right) :- append(Left, [Pivot|Right], List).

% List replace.
replace(_, _, [], []).
replace(O, R, [O|T], [R|T2]) :- replace(O, R, T, T2).
replace(O, R, [H|T], [H|T2]) :- H \= O, replace(O, R, T, T2).

% receive([[I|J]|Types]) :-
%     length(J) > 0,
%     write('Do you have the information about '),
%     write(I),
%     write('? (Y/n)'), nl,
%     read(Suggestion),
%     (Suggestion = Y, ).
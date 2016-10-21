:- module(service_cli, []).

:- use_module(knowledge_base, []).

:- initialization(init).

init :-
    nl,
    write('==============================='), nl,
    write('WhereTo v0.1'), nl,
    write('We resolve your destination...'), nl,
    write('==============================='), nl,
    main.

main :-
    Types = [activity, month, country],
    Info = [activity, month, country, continent],
    
    nl, write('Which suggestion do you need? '),

    write(Types), nl,
    read(Suggestion),

    ((Suggestion == country, append(Types, [continent], FilteredTypes)); (Suggestion \= country, FilteredTypes = Types)),
%   write('FilteredTypes: '), write(FilteredTypes), nl,

    split(FilteredTypes, Suggestion, Left, Right),
    append(Left, Right, NewTypes),

%   replace(Suggestion, [Suggested], Info, NewInfo),

%   write(NewInfo), nl,
%   write('NewTypes: '), write(NewTypes), nl,
%   write(Suggested), nl,
    
    receive(NewTypes, Info, PopulatedInfo),
%   write('PopulatedInfo: '), write(PopulatedInfo), nl,

    replace(Suggestion, Suggested, PopulatedInfo, QueryInfo),
%   write('QueryInfo: '), write(QueryInfo), nl,
    
    write('Suggested: '), nl,
    query_kb(QueryInfo),
%   (var(Suggested) -> (write('\t* None *'), nl)),    
    format('\t* ~w\n', [Suggested]), fail; true,
    nl, main.

query_kb(Infos) :-
    nth1(1, Infos, Activity),
    nth1(2, Infos, Month),
    nth1(3, Infos, Country),
    nth1(4, Infos, Continent),
    ((Continent == continent, QueryContinent = _); (Continent \= continent, QueryContinent = Continent)),
    rules_activity:activity(Activity, Month, QueryContinent, Country).

receive([], Infos, Return) :- Return = Infos.
receive([Type|Types], Infos, Return) :-
    write('Please provide \''), write(Type), write('\' ...'),
    read(ReadIn),
    replace(Type, ReadIn, Infos, PopulatedInfo),
    receive(Types, PopulatedInfo, Return).

% List split.
split(List, Pivot, Left, Right) :- append(Left, [Pivot|Right], List).

% List replace.
replace(_, _, [], []).
replace(O, R, [O|T], [R|T2]) :- replace(O, R, T, T2).
replace(O, R, [H|T], [H|T2]) :- H \= O, replace(O, R, T, T2).

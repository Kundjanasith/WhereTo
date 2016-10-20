:- module(server, []).

:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_cors)).
:- use_module(library(http/http_json)).
:- use_module(library(http/json_convert)).
:- use_module(library(option)).
:- use_module(library(settings)).
:- http_handler(root(.), handle, []).

:- set_setting(http:cors, [*]).

% :- json_object
%     response(res: text).

start_server(PORT) :-
    http_server(http_dispatch, [port(PORT)]).

handle(REQUEST) :-
    format(user_output, "Incoming request: ~w~n", [REQUEST]),
    cors_enable,
    CONTINENT = REQUEST.search.continent,
    ACTIVITY = REQUEST.search.activity,
    MONTH = REQUEST.search.month,
    RESPONSE = [CONTINENT, ACTIVITY, MONTH],
    %term_string(REQUEST.search, R0),
    %term_string(password(REQUEST.search.password), R1),
    prolog_to_json(RESPONSE, RESPONSE),
    reply_json(RESPONSE).
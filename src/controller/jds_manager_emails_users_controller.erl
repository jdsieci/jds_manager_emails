%% Author: tofik
%% Created: 25-02-2013
%% Description: TODO: Add description to jds_manager_emails_users_controller

-module(jds_manager_emails_users_controller, [Req, SessionID]).
%-compile(export_all).
%%
%% Include files
%%
-include("email_users.hrl").
-include("email_domains.hrl").
%%
%% Exported Functions
%%
-export([list/2, add/2, delete/2]).

%%
%% API Functions
%%
list('GET', []) ->
    Users = boss_db:find(email_users, []),
    {ok, [{users, Users}]};
list('GET', [Domain]) ->
    {ok, #email_domains{id=DomainId}} = boss_db:find(email_domains, [{name, 'equals', Domain}]),
    Users = boss_db:find(email_users, [{email_domains_id, 'equals', DomainId}]),
    {ok, [{users, Users}, {domain, Domain}]}.

add('GET', []) ->
    Domains = boss_db:find(email_domains, []),
    {ok, [{domains, Domains}]};
add('GET', [Domain]) ->
    Domains = boss_db:find(email_domains, [{name, 'equals', Domain}]),
    {ok, [{domains, Domains}]};
add('POST', []) ->
    {Username, Password, Password2, DomainID} = get_from_post(["username", "password", "password2", "domainid"]),
    % TODO: Ustawic pobieranie ID clienta z sesji
    NewUser = email_users:new(id, Username, Password, DomainID, 1),
    {ok, SavedUser} = NewUser:save(),
    {redirect, [{action, "list"}]};
add('POST', [Domain]) ->
    {ok, #email_domains{id=DomainID}} = boss_db:find(email_domains, [{name, 'equals', Domain}]),
    {Username, Password, Password2} = get_from_post(["username", "password", "password2"]),
    NewUser = email_users:new(id, Username, Password, DomainID, 1),
    {ok, SavedUser} = NewUser:save(),
    {redirect, [{action, "list"}, {domain, Domain}]}.

delete('GET', [UserId]) ->
    boss_db:delete(UserId),
    {redirect, [{action, "list"}]};
delete('POST', []) ->
    boss_db:delete(Req:post_param("user_id")),
    {redirect, [{action, "list"}]}.
%%
%% Local Functions
%%
get_from_post(Fields) ->
    get_from_post(Fields, []).
get_from_post([], Acc) ->
    list_to_tuple(lists:reverse(Acc));
get_from_post([Field | Rest], Acc) ->
    get_from_post(Rest, [Req:post_param(Field) | Acc]).

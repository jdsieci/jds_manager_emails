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
-export([list/2, add/2]).

%%
%% API Functions
%%
list('GET', []) ->
    Users = boss_db:find(email_users, []),
    {ok, [{users, Users}]};
list('GET', [Domain]) ->
    {ok, #email_domains{id=DomainId}} = boss_db:find(email_domains, [{name, 'equals', Domain}]),
    Users = boss_db:find(email_users, [{email_domains_id, 'equals', DomainId}]),
    {ok, [{users, Users}]}.

add('GET', []) ->
    Domains = boss_db:find(email_domains, []),
    {ok, [{domains, Domains}]};
add('GET', [Domain]) ->
    Domains = boss_db:find(email_domains, [{name, 'equals', Domain}]),
    {ok, [{domains, Domains}]};
add('POST', []) ->
    {Username, Password, DomainID} = get_from_post(["username", "password", "domainid"]),
    % TODO: Ustawic pobieranie ID clienta z sesji
    NewUser = email_users:new(id, Username, Password, DomainID, 1),
    {ok, SavedUser} = NewUser:save(),
    {redirect, {action, "list"}};
add('POST', [Domain]) ->
    {redirect, [{action, "list"}, {domain, Domain}]}.

del('POST', []) ->
    {redirect, {action, "list"}}.
%%
%% Local Functions
%%

get_from_post() ->
    {Req:post_param("username"),
    Req:post_param("password"),
    Req:post_param("domainid")}.
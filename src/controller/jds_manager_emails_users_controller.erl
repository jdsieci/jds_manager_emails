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
-export([index/2, list/2, add/2, delete/2, edit/2]).

%%
%% API Functions
%%

index(Method, Rest) ->
    list(Method, Rest).

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
    case add_user(Username, Password, DomainID) of
        redirect ->
            {redirect, [{action, "list"}]};
        {ok, Rest} ->
            Domains = boss_db:find(email_domains, []),
            {ok, [{domains, Domains} | Rest]}
    end;
add('POST', [Domain]) ->
    {ok, #email_domains{id = DomainID} = DomainRecord} = boss_db:find(email_domains, [{name, 'equals', Domain}]),
    {Username, Password, Password2} = get_from_post(["username", "password", "password2"]),
    case add_user(Username, Password, DomainRecord#email_domains.id) of
        redirect ->
            {redirect, [{action, "list"}, {domain, Domain}]};
        {ok, Rest} ->
            Domains = boss_db:find(email_domains, [{name, 'equals', Domain}]),
            {ok, [{domains, DomainRecord} | Rest]}
    end.

delete('GET', [UserId]) ->
    boss_db:delete(UserId),
    {redirect, [{action, "list"}]};
delete('POST', []) ->
    boss_db:delete(Req:post_param("user_id")),
    {redirect, [{action, "list"}]}.

edit('GET', [UserId]) ->
    Domains = boss_db:find(email_domains, []),
    User = boss_db:find(UserId),
    io:fwrite("~p~n", [User]),
    {ok, [{domains, Domains}, {user, User}]};
edit('POST', [UserId]) ->
    {Id, UserName, Password, Password2, DomainId} = get_from_post(["id", "username", "password", "password2", "domainid"]),
    User = boss_db:find(UserId),
    case edit_user(User, [{username, UserName}, {password, Password}, {domain, DomainId}]) of
        redirect ->
            {redirect, [{action, "list"}]};
        {ok, Rest} ->
            Domains = boss_db:find(email_domains, []),
            {ok, [{domains, Domains} | Rest]}
    end.

%%
%% Local Functions
%%
get_from_post(Fields) ->
    get_from_post(Fields, []).
get_from_post([], Acc) ->
    list_to_tuple(lists:reverse(Acc));
get_from_post([Field | Rest], Acc) ->
    get_from_post(Rest, [Req:post_param(Field) | Acc]).

add_user(Username, Password, DomainID) ->
    % TODO: Ustawic pobieranie ID klienta z sesji
    NewUser = email_users:new(id, Username, Password, DomainID, 1),
    case NewUser:save() of
        {ok, SavedUser} ->
            redirect;
        {error, ErrorList} ->
            {ok, [{errors, ErrorList}, {new_user, NewUser}]}
    end.

edit_user(User, []) ->
    case User:save() of
        {ok, SavedUser} ->
            redirect;
        {error, ErrorList} ->
            {ok, [{errors, ErrorList}, {user, User}]}
    end;
edit_user(User, [{username, UserName} | Tail]) ->
    edit_user(User:set(username, UserName), Tail);
edit_user(User, [{password, Password} | Tail]) ->
    edit_user(User:set(password, Password), Tail);
edit_user(User, [{domain, DomainId} | Tail]) ->
    edit_user(User:set(email_domains_id, DomainId),Tail).
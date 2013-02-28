%% Author: tofik
%% Created: 28-02-2013
%% Description: TODO: Add description to jds_manager_emails_domains_controller
-module(jds_manager_emails_domains_controller, [Req, SessionID]).

%%
%% Include files
%%
-include("email_domains.hrl").

%%
%% Exported Functions
%%
-export([list/2, add/2, del/2]).

%%
%% API Functions
%%


list('GET', []) ->
    Domains = boss_db:find(email_domains, []),
    {ok, [{domains, Domains}]}.

add('GET', []) ->
    ok;
add('POST', []) ->
    DomainName = Req:post_param("domain_name"),
    % TODO: Ustawic pobieranie ID clienta z sesji
    NewDomain = email_domains:new(id, DomainName, 1),
    {ok, SavedDomain} = NewDomain:save(),
    {redirect, [{action, "list"}]}.


del('POST', []) ->
    boss_db:delete(Req:post_param("domain_id")),
    {redirect, [{action, "list"}]}.

%%
%% Local Functions
%%


%% Author: tofik
%% Created: 24-02-2013
%% Description: TODO: Add description to virtual_domains
-module(email_domains,[Id, Name, ClientId]).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([constraints_create/0]).

%%
%% API Functions
%%
constraints_create() ->
    [{fun() -> [] == boss_db:find(email_domains, [{email_domains_id, 'equals', EmailDomainsId}])
      end, "Domain exists"}].



%%
%% Local Functions
%%


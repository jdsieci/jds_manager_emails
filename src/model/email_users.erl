%% -*- coding: utf-8 -*-
%% Author: tofik
%% Created: 24-02-2013
%% Description: TODO: Add description to virtual_users
-module(email_users,[Id,
                     Username::string(),
                     Password::string(),
                     EmailDomainsId,
                     ClientId::integer()]).
-belongs_to(email_domains).
%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([validation_tests/0, before_create/0]).

%%
%% API Functions
%%
validation_tests() ->
    %[{fun() -> [] == boss_db:find(email_users, [{username, 'equals', Username},
    %                                            {email_domains_id, 'equals', EmailDomainsId}])
    %  end, "User exists"}].
    [].

before_create() ->
    case boss_db:find(email_users, [{username, 'equals', Username},
                                    {email_domains_id, 'equals', EmailDomainsId}]) of
        [] -> ok;
        _ -> {error, ["User Exists"]}
    end.
%%
%% Local Functions
%%


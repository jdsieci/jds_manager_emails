%% -*- coding: utf-8 -*-
%% Author: tofik
%% Created: 24-02-2013
%% Description: TODO: Add description to virtual_users
-module(email_users,[Id,
                     Username::string(),
                     Password,
                     EmailDomainsId,
                     ClientId::integer()]).
-belongs_to(email_domains).
%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([validation_tests/0,
         constraints_create/0,
         before_create/0,
         before_update/0]).

%%
%% API Functions
%%
validation_tests() ->
    %[{fun() -> [] == boss_db:find(email_users, [{username, 'equals', Username},
    %                                            {email_domains_id, 'equals', EmailDomainsId}])
    %  end, "User exists"}].
    [].

constraints_create() ->
    [{fun() -> [] == boss_db:find(email_users, [{username, 'equals', Username},
                                                {email_domains_id, 'equals', EmailDomainsId}])
      end, "User exists"}].


before_create() ->
    ModifiedRecord = set(password, hash_password()),
    {ok, ModifiedRecord}.

before_update() ->
    ModifiedRecord = set(password, hash_password()),
    {ok, ModifiedRecord}.


%%
%% Local Functions
%%

hash_password() ->
    lists:flatten([io_lib:fwrite("~2.16.0b", [Byte]) || Byte <- binary_to_list(erlang:md5(Password))]).
-module(gen_event_forwarder_tests).
-include_lib("eunit/include/eunit.hrl").

event_relay_test() ->
    {ok, EventMgr} = gen_event:start_link(),
    gen_event:add_handler(EventMgr, gen_event_forwarder, [self()]),
    gen_event:notify(EventMgr, test_event),
    receive
        X ->
            ?assertEqual({gen_event, EventMgr, event, test_event}, X)
    end.

info_relay_test() ->
    {ok, EventMgr} = gen_event:start_link(),
    gen_event:add_handler(EventMgr, gen_event_forwarder, [self()]),
    EventMgr ! test_msg,
    receive
        X ->
            ?assertEqual({gen_event, EventMgr, info, test_msg}, X)
    end.



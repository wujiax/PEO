% 结构体uploaddata
:- dynamic uploaddata/4.
uploaddata(Timestamp, Type, ObAttr, Hash) :-
    member(time, Attributes),
    member(type_, Attributes),
    member(obAttr, Attributes),
    member(hash, Attributes).

% 映射st
:- dynamic st/2.
st(ObAttrId, UploadData) :-
    uploaddata(_, _, ObAttrId, _).

% 结构体returndata
:- dynamic returndata/4.
returndata(RequestId, Hash, Data, ObAttrId) :-
    member(requestId, Attributes),
    member(hash, Attributes),
    member(data, Attributes),
    member(obAttrId, Attributes).

% 映射ss
:- dynamic ss/2.
ss(RequestId, ReturnData) :-
    returndata(RequestId, _, _, _).

% 全局变量attrlen
:- dynamic attrlen/1.
attrlen(Length).

% 结构体attributetable
:- dynamic attributetable/5.
attributetable(AttrId, SubAttrId, ObAttrId, AcAttrId, ResTime) :-
    member(attrId, Attributes),
    member(subAttrId, Attributes),
    member(obAttrId, Attributes),
    member(acAttrId, Attributes),
    member(res_time, Attributes).

% 映射qu
:- dynamic qu/2.
qu(AttrId, AttributeTable) :-
    attributetable(AttrId, _, _, _, _).

% 函数attributetable_add
attributetable_add(SubAttrId, ObAttrId, ResTime, AcAttrId) :-
    assertz(attributetable(AttrId, SubAttrId, ObAttrId, AcAttrId, ResTime)),
    retract(attrlen(Length)),
    NewLength is Length + 1,
    assertz(attrlen(NewLength)).

% 函数attributetable_Q
attributetable_Q(SubAttrId, ObAttrId, ResTime, AcAttrId) :-
    qu(_, AttributeTable),
    member(subAttrId, AttributeTable, SubAttrId),
    member(obAttrId, AttributeTable, ObAttrId),
    member(acAttrId, AttributeTable, AcAttrId),
    member(res_time, AttributeTable, ResTime).

% 函数attributetable_delet
attributetable_delet(Atid) :-
    attributetable(Atid, _, _, _, _),
    retract(attributetable(Atid, _, _, _, _)),
    retract(attrlen(Length)),
    NewLength is Length - 1,
    assertz(attrlen(NewLength)).

% 函数attributetable_mod
attributetable_mod(Atid, ResTime, AcAttrId) :-
    attributetable(Atid, SubAttrId, ObAttrId, _, _),
    retract(attributetable(Atid, _, _, _, _)),
    assertz(attributetable(Atid, SubAttrId, ObAttrId, AcAttrId, ResTime)).

% 函数compare
compare(Timestamp1, Timestamp2) :-
    Timestamp1 =< Timestamp2.

% 函数sy_storage_1
sy_storage_1(Hash, Type, ObAttr) :-
    assertz(uploaddata(Timestamp, Type, ObAttr, Hash)).

% 全局变量count
:- dynamic count/1.
count(Counter).

% 全局变量GAS_PRICE
:- dynamic gas_price/1.
gas_price(Price).

% 函数query_users
query_users(DynamicId, SubAttrId, ObAttrId, ResTime, AcAttrId, RequestId) :-
    qu(_, AttributeTable),
    member(subAttrId, AttributeTable, SubAttrId),
    member(obAttrId, AttributeTable, ObAttrId),
    member(acAttrId, AttributeTable, AcAttrId),
    member(res_time, AttributeTable, ResTime),
    compare(ResTime, CurrentTime),
    gas_price(GasPrice),
    retract(count(Counter)),
    NewCounter is Counter + 1,
    assertz(count(NewCounter)),
    assertz(ss(NewCounter, returndata(RequestId, _, _, _))),
    assertz(returndata(RequestId, _, _, _)).

% 函数sy_storage_2
sy_storage_2(RequestId, Hash, Data, ObAttrId) :-
    ss(RequestId, returndata(RequestId, _, _, _)),
    retract(ss(RequestId, _)),
    assertz(ss(RequestId, returndata(RequestId, Hash, Data, ObAttrId))).

% 函数user_get
user_get(RequestId, Data) :-
    ss(RequestId, returndata(RequestId, Hash, Data, _)),
    uploaddata(_, _, _, Hash),
    retract(ss(RequestId, _)).

% 函数utilCompareInternal
utilCompareInternal(A, B) :-
    A = B.

% 函数utilStringLength
utilStringLength(Str, Length) :-
    string_length(Str, Length).

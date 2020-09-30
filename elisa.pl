:- consult('main.pl').

elisa:-
	load,
	out("Hello, Im Elisa, how may I help you?"),
	elisa([hi]).

elisa([quit|_]):-!.

elisa(_):-
	in(Line),
	simplify(Line, Words),
	findResponse(Words,Reply),
	writeWords(Reply),nl,
	elisa(Words).

:- dynamic resID/2.
resID(_,0).

% Loads dependencies
load:-
	consult("simplification.rules"),
	consult("reply.rules").	

% Simplifies the input
simplify(In, Out):-
	deleteChars(In, punctuation, Out1),
	toWords(Out1,Out2),
	synonyms(Out2,Out3),
	Out = Out3.

synonyms(Words, Syn) :-
	simplification(Words, Syn, RestWords, ResOutput),!,
	synonyms(RestWords, ResOutput).
synonyms([Word| ResWords], [Word| ResSyn]):-
	synonyms(ResWords, ResSyn),!.
synonyms([], []).

% Find a suitable reply based on input
findResponse(Words, Reply) :-
	findResponse2(Words, -2, 0, [], ID, Reply),
	ID \= 0,
	betterResponse(ID).

findResponse2([H|T], ActScore, _, _, ID, Res):-
	findall(Score,rules(_, Score,[H|T],_),Rules),
	Rules \= [],
	max_list(Rules,NewScore),
	ActScore < NewScore,
	rules(NewID, NewScore,[H|T],Replyes),
	resID(NewID,ResID),
	nth0(ResID,Replyes,NewReply),
	findResponse2(T, NewScore, NewID, NewReply, ID, Res),!.
findResponse2([_|T], ActScore, ActID, ActRes, ID, Res):-
	findResponse2(T, ActScore, ActID, ActRes, ID, Res).
findResponse2([], _, ID, Res, ID, Res).

% Chooses a better reply
betterResponse(ID):-
	resID(ID,RID),
	once(rules(ID,_,_,Replyes)),
	length(Replyes, Len),
	NRID is (RID + 1) mod Len,
	retract((resID(ID,RID):-!)),
	asserta(resID(ID,NRID):-!),!.
betterResponse(ID):-
	resID(ID,RID),
	once(rules(ID,_,_,Replyes)),
	length(Replyes, Len),
	NRID is (RID + 1) mod Len,
	asserta(resID(ID,NRID):-!).

% Writes words..
writeWords([Word|Res]):-
	string_chars(Word,[Char|RChar]),
	toUpperCase(Char,UChar),
	readWord([UChar|RChar],Out,_),
	out(Out),
	writeWords2(Res).

writeWords2([Word|Res]):-
	is_list(Word),
	writeWords2(Word),
	writeWords2(Res),!.

writeWords2([Word|Res]):-
	symbol(Word,punctuation),
	out(Word),
	writeWords2(Res),!.

writeWords2([Word|Res]):-
	out(" "),
	out(Word),
	writeWords2(Res),!.
writeWords2([]).
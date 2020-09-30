%To print output
out(Text):-write(Text).

%To take input
in(Text):-
	nl,
	write("> "),
	readLine(Text).

readLine(Text):-
	get_char(Char),
	toLowerCase(Char,LChar),
	readLine2(LChar,Text).
readLine2('\n',[]):-!.
readLine2(LChar,[LChar|T]):-readLine(T).

% Defining characters to be omitted
symbol('!', punctuation).
symbol('?', punctuation).
symbol('.', punctuation).
symbol(',', punctuation).
symbol('\'', punctuation).
symbol(' ', whitespace).
symbol('\t', whitespace).

% Some utility functions
toLowerCase(Char, LChar):-
	char_code(Char, Code),
	Code >= "A",
	Code =< "Z",
	NewCode is Code + 32,
	char_code(LChar, NewCode), !.
toLowerCase(Char, Char).

toUpperCase(Char, UChar):-
	char_code(Char, Code),
	Code >= "a",
	Code =< "z",
	NewCode is Code - 32,
	char_code(UChar, NewCode), !.
toUpperCase(Char, Char).

% Deletes said characters
deleteChars([Char|Rest],Type,Out):-
	symbol(Char, Type),
	deleteChars(Rest,Type,Out),!.
deleteChars([Char|Rest],Type,[Char|Out]):-
	deleteChars(Rest,Type,Out),!.
deleteChars([],_,[]).

% Converts input sentence into list of words
toWords([],[]):-!.
toWords(Line, [Word|ResWords]):-
	readWord(Line, Word, ResLine),
	toWords(ResLine, ResWords).

% Reads a word from line
readWord([], '', []).
readWord([Char|Res], '', Res) :- symbol(Char, whitespace),!.
readWord([Char|ResLine], Word, Res) :- 
	readWord(ResLine, ResWord, Res),
	atom_concat(Char, ResWord, Word).
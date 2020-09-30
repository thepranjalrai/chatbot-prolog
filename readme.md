# An Elisa like chatbot
This repo consists of a chatbot written in Prolog which is aimed for making casual conversations with people seeking counselling.

## Instructions to execute
> Make sure you have SWI Prolog installed.
1. Extract the repo to a directory and open terminal in it.
2. Enter the following command to start the prolog interpreter.
~~~
$ swipl
~~~
3. In the prolog interpreter, typt the following line to load the chatbot's files.
~~~
?− ['elisa.pl'].
~~~
4. The predicate to invoke the chatbot is
~~~
?- elisa.
~~~

## Following is a sample snippet of the chatbot.
~~~
?- elisa.
Hello, Im Elisa, how may I help you?
Hi Elisa, would you like to know my name?
> I am not interested in names.

I am feeling sad
> I am sorry to hear you are sad.

what should i do
> Why do you ask?

because i am sad
> Do you think coming here will help you not to be sad?

yes
> You are sure?

yes
> I see.

can you help me
> Plese tell me more ...

i am sad because i am not studying
> I am sure it is not pleasant to be sad.

yes
> I understand.

I have to go, see you later, bye.
> Goodbye. it was nice talking to you. I hope you were helped.
true.

?- halt.
~~~
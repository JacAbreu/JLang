# JLang

Just a simple template language ANTLR4 grammar.

## Some compatible code examples

mixing plain text with code:
````
2+2/2 = <?2+2/2?>.
````

loop for:
````
<% for (int i=0; i<10; i++) { %>
<? i ?>
<% } %>`
````

loop while:
````
<%
var i = 0; 
while (i < 10) { 
%>
<? i ?>
<%
    i++; 
} 
%>
````

if-elseif-elseif-else:
````
<% 
if (a<10) { 
%>

a < 10

<% 
} else if (a < 20) {
%>

a < 20

<% 
} else if (a < 30) {
%>

a < 30

<% 
} else {
%>

a is big

<%    
}
%>
````

## Getting started

* clone this repo
* install java jdk
* install antlr
* execute ````test.bat```` (windows only)


## Visualizing the Parse Tree

just execute ````gui <source-code>`````

this is the output for ````gui samples\mixing-content-with-scripts.j````

![sample](sample.png) 

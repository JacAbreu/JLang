parser grammar JLangParser;

options { tokenVocab=JLangLexer; }

template
    : elements EOF
    ;

elements
    : element *
    ;

element
    : raw
    | BEGIN_SCRIPT_BLOCK script END_SCRIPT_BLOCK
    ;

raw
    : RAW
    ;

script
    :  expression
    ;

expression
    : expression op=(STAR|DIV) expression
    | INTEGER_LITERAL
    | REAL_LITERAL
    | '(' expression ')'
    ;


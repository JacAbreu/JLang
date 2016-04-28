lexer grammar JLangLexer;

RAW
    : RAW_CHAR+
    ;

RAW_CHAR
    : ~[@]
    | '\\@'
    ;

BEGIN_SCRIPT_BLOCK
    : '@{' -> pushMode(SCRIPT)
    ;

mode SCRIPT;

END_SCRIPT_BLOCK
    : '}' -> popMode
    ;

INTEGER_LITERAL
    : [0-9]+ IntegerTypeSuffix?
    ;

REAL_LITERAL
    : [0-9]* '.' [0-9]+ ExponentPart? [FfDdMm]? 
    | [0-9]+ ([FfDdMm] | ExponentPart [FfDdMm]?)
    ;

fragment 
IntegerTypeSuffix
    : [lL]? [uU] | [uU]? [lL];

fragment 
ExponentPart
    : [eE] ('+' | '-')? [0-9]+
    ;

PLUS:                     '+';
MINUS:                    '-';
STAR:                     '*';
DIV:                      '/';

LPAREN:                   '(';
RPAREN:                   ')';

WS
    : [ \t\r\n]+ -> skip
    ;
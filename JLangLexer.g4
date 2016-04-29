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

// ------------------------------------------------------------------

mode SCRIPT;

END_SCRIPT_BLOCK
    : '}' -> popMode
    ;

IDENTIFIER
    : '@'? IdentifierStartCharacter IdentifierPartCharacter*
    ;

fragment 
IdentifierStartCharacter
    : [a-zA-Z]
    | '_'
    ;

fragment 
IdentifierPartCharacter
    : [a-zA-Z]
    | [0-9]
    | '_'
    ;

// ------------------------------------------------------------------
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

// ------------------------------------------------------------------
EXPO:                     '^';
PLUS:                     '+';
MINUS:                    '-';
STAR:                     '*';
DIV:                      '/';

LOGICAL_AND:              '&';
LOGICAL_OR:               '|';
LOGICAL_XOR:              '^';

CONDITIONAL_AND:          '&&';
CONDITIONAL_OR:           '||';

MOD:                      '%';

SHIFTL:                   '<<';
SHIFTR:                   '>>';

EQ:                       '==';
NEQ:                      '!=';
LT:                       '<';
LEQ:                      '<=';
GT:                       '>';
GEQ:                      '>=';

ASGN:                     '=';
PLUS_ASGN:                '+=';
MINUS_ASGN:               '-=';
STAR_ASGN:                '*=';
DIV_ASGN:                 '/=';
MOD_ASGN:                 '%=';
AND_ASGN:                 '&=';
OR_ASGN:                  '|=';
XOR_ASGN:                 '^=';



POW:                      'pow';

EXCLAMATION:              '!';
QUESTION:                 '?';
COLON:                    ':';
SEMICOLON:                ';';
COMMA:                    ',';


LPAREN:                   '(';
RPAREN:                   ')';

TRUE:                     'true';
FALSE:                    'false';

// ------------------------------------------------------------------
WS
    : [ \t\r\n]+ -> skip
    ;

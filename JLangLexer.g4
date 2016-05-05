lexer grammar JLangLexer;

RAW
    : (RAW_CHAR)+
    ;

RAW_CHAR 
    : ~[<\r\n]
    | '\r'? '\n'
    | '<' ~[?%]
    ;


OPEN_ECHOSCRIPT_BLOCK
    : '<?' -> pushMode(SCRIPT)
    ;


OPEN_SCRIPT_BLOCK
    : '<%' -> pushMode(SCRIPT)
    ;

// ------------------------------------------------------------------

mode SCRIPT;

CLOSE_ECHOSCRIPT_BLOCK
    : '?>' -> popMode
    ;

CLOSE_SCRIPT_BLOCK
    : '%>' ('\r'? '\n')? -> popMode
    ;

CLOSE_BRACE
    : '}' 
    ;

OPEN_BRACE
    : '{' 
    ;

// ------------------------------------------------------------------
IF:     'if';
ELSE:   'else';
WHILE:  'while';
DO:     'do';
FOR:    'for';
FOREACH:'foreach';
IN:     'in';
GOTO:   'goto';
BREAK:  'break';
CONTINUE:'continue';

// ------------------------------------------------------------------
TYPE_BOOL: 'bool';
TYPE_DECIMAL: 'decimal';
TYPE_BYTE: 'byte';
TYPE_SHORT: 'short';
TYPE_INT: 'int';
TYPE_LONG: 'long';
TYPE_CHAR: 'char';
TYPE_FLOAT: 'float';
TYPE_DOUBLE: 'double';
TYPE_OBJECT: 'object';
TYPE_STRING: 'string';

// ------------------------------------------------------------------
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
INC:                      '++';
DEC:                      '--';
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
DOT:                      '.';

LPAREN:                   '(';
RPAREN:                   ')';

LBRACKET:                 '[';
RBRACKET:                 ']';

TRUE:                     'true';
FALSE:                    'false';

STRING:           '"'  (~["\\\r\n\u0085\u2028\u2029] | CommonCharacter)* '"';

fragment CommonCharacter
	: SimpleEscapeSequence
	| HexEscapeSequence
	;

fragment SimpleEscapeSequence
	: '\\\''
	| '\\"'
	| '\\\\'
	| '\\0'
	| '\\a'
	| '\\b'
	| '\\f'
	| '\\n'
	| '\\r'
	| '\\t'
	| '\\v'
	;
fragment HexEscapeSequence
	: '\\x' HexDigit
	| '\\x' HexDigit HexDigit
	| '\\x' HexDigit HexDigit HexDigit
	| '\\x' HexDigit HexDigit HexDigit HexDigit
	;

fragment HexDigit : [0-9] | [A-F] | [a-f];      

WS
    : [ \r\n\t]+ -> skip
    ;

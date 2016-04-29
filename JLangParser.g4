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
    : script_element (';' script_element)*
    ;

script_element
    : expression                                
    | assign                                    
    ;

expression
    : op=(PLUS|MINUS) expression                      # Unary
    | EXCLAMATION expression                          # BooleanNot
    | POW LPAREN expression COMMA expression RPAREN   # Expo
    | expression op=(STAR|DIV|MOD) expression         # Multiplicative
    | expression op=(PLUS|MINUS) expression           # Additive
    | expression op=(SHIFTL|SHIFTR) expression        # Shit
    | expression op=('<=' | '<' | '>=' | '>')         # Relational
    | expression op=('==' | '!=') expression          # Equality
    | expression LOGICAL_AND expression               # LogicalAnd
    | expression LOGICAL_XOR expression               # LogicalXor
    | expression LOGICAL_OR expression                # LogicalOr
    | expression CONDITIONAL_AND expression           # ConditionalAnd
    | expression CONDITIONAL_OR expression            # ConditionalOr
    | expression '?' expression ':' expression        # Ternary
    | INTEGER_LITERAL                                 # Integer
    | REAL_LITERAL                                    # Double
    | boolean_literal                                 # Boolean
    | IDENTIFIER                                      # Identifier
    | '(' expression ')'                              # Parens
    ;

boolean_literal
    : TRUE
    | FALSE
    ;

assign 
    : IDENTIFIER op=('=' | '+=' | '-=' | '*=' | '/=' | '%=' | '&=' | '|=' | '^=')  expression  
    ;
parser grammar JLangParser;

options { tokenVocab=JLangLexer; }

template
    : elements EOF
    ;

elements
    : element *
    ;

element
    : OPEN_ECHOSCRIPT_BLOCK statement_list CLOSE_ECHOSCRIPT_BLOCK
    | OPEN_SCRIPT_BLOCK statement_list CLOSE_SCRIPT_BLOCK
    | RAW
    ;

statement_list
    : statement (';' statement)*
    ;

statement
    : IDENTIFIER ':' statement
    | embedded_statement
    ;

embedded_statement
    : block_statement
    | simple_embedded_statement
    ;

block_statement
    : OPEN_BRACE statement_list? CLOSE_BRACE
    ;
          

simple_embedded_statement
    : ';'
    | expression ';'? 
    | IF LPAREN expression RPAREN if_body (ELSE if_body)?
    ;

expression
    : assign                                          # AssignExpression
    | op=(PLUS|MINUS) expression                      # UnaryExpression
    | EXCLAMATION expression                          # BooleanNotExpression
    | POW LPAREN expression COMMA expression RPAREN   # ExpoExpression
    | expression op=(STAR|DIV|MOD) expression         # MultiplicativeExpression
    | expression op=(PLUS|MINUS) expression           # AdditiveExpression
    | expression op=(SHIFTL|SHIFTR) expression        # ShiftExpression
    | expression op=('<=' | '<' | '>=' | '>') expression         # RelationalExpression
    | expression op=('==' | '!=') expression          # EqualityExpression
    | expression LOGICAL_AND expression               # LogicalAndExpression
    | expression LOGICAL_XOR expression               # LogicalXorExpression
    | expression LOGICAL_OR expression                # LogicalOrExpression
    | expression CONDITIONAL_AND expression           # ConditionalAndExpression
    | expression CONDITIONAL_OR expression            # ConditionalOrExpression
    | expression '?' expression ':' expression        # TernaryExpression
    | INTEGER_LITERAL                                 # IntegerExpression
    | REAL_LITERAL                                    # DoubleExpression
    | boolean_literal                                 # BooleanExpression
    | IDENTIFIER                                      # IdentifierExpression
    | '(' expression ')'                              # ParensExpression
    ;


if_body
    : block_statement
    | simple_embedded_statement
    ;

boolean_literal
    : TRUE
    | FALSE
    ;

assign 
    : IDENTIFIER op=('=' | '+=' | '-=' | '*=' | '/=' | '%=' | '&=' | '|=' | '^=')  expression  
    ;
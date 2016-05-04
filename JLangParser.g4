parser grammar JLangParser;

options { tokenVocab=JLangLexer; }

template
    : elements EOF
    ;

elements
    : element *
    ;

element
    : echo_script
    | plain_script 
    | fragmented_script_if
    | fragmented_script
    | RAW
    ;

echo_script 
    : OPEN_ECHOSCRIPT_BLOCK statement_list CLOSE_ECHOSCRIPT_BLOCK
    ;

plain_script
    : OPEN_SCRIPT_BLOCK statement_list CLOSE_SCRIPT_BLOCK
    ;

fragmented_script
    : fragmented_script_start elements (fragmented_script_middle elements)* fragmented_script_end
    ;

fragmented_script_if
    : fragmented_script_start_if elements 
      ( (fragmented_script_middle elements)+
        | (fragmented_script_middle_else elements) 
      )? 
      (fragmented_script_end | fragmented_script_end_else)
    ;


fragmented_script_start
    : OPEN_SCRIPT_BLOCK (statement_list ';')? fragmented_statement (statement_list ';')? CLOSE_SCRIPT_BLOCK
    ;

fragmented_script_start_if
    : OPEN_SCRIPT_BLOCK (statement_list ';')? fragmented_statement_if (statement_list ';')? CLOSE_SCRIPT_BLOCK
    ;

fragmented_script_middle_else
    : OPEN_SCRIPT_BLOCK (statement_list ';')? '}' ELSE '{' (statement_list ';')? CLOSE_SCRIPT_BLOCK
    | OPEN_SCRIPT_BLOCK (statement_list ';')? '}' ELSE if_body fragmented_statement (statement_list ';')? CLOSE_SCRIPT_BLOCK
    ;

fragmented_script_middle
    : OPEN_SCRIPT_BLOCK (statement_list ';')? '}' (statement_list)? fragmented_statement (statement_list ';')? CLOSE_SCRIPT_BLOCK
    ;

fragmented_script_end_else
    : OPEN_SCRIPT_BLOCK (statement_list ';')? '}' (ELSE if_body)? (statement_list)? CLOSE_SCRIPT_BLOCK
    | OPEN_SCRIPT_BLOCK (statement_list ';')? '}' ELSE  fragmented_statement_if (statement_list ';')? CLOSE_SCRIPT_BLOCK elements 
      ( (fragmented_script_middle elements)+
        | (fragmented_script_middle_else elements) 
      )? 
      (fragmented_script_end | fragmented_script_end_else)
    ;

fragmented_script_end
    : OPEN_SCRIPT_BLOCK (statement_list ';')? '}' (statement_list)? CLOSE_SCRIPT_BLOCK
    ;
        

statement_list
    : statement (';' statement)*
    ;

statement
    : IDENTIFIER ':' statement
    | local_variable_declaration
    | embedded_statement
    ;

embedded_statement
    : block_statement
    | simple_embedded_statement
    ;

block_statement
    : OPEN_BRACE statement_list? CLOSE_BRACE
    ;
          
local_variable_declaration
    : type local_variable_declarator ( ','  local_variable_declarator)*
    ;

local_variable_declarator
    : IDENTIFIER ('=' expression)?
    ;

type
    : simple_type
    | class_type
    ;

simple_type
    : numeric_type 
    | BOOL 
    ;

numeric_type 
    : integral_type
    | floating_point_type
    | DECIMAL
    ;

integral_type 
    : BYTE
    | SHORT
    | INT
    | LONG
    | CHAR
    ;

floating_point_type 
    : FLOAT
    | DOUBLE
    ;

class_type 
    : namespace_or_type_name
    | OBJECT
    | STRING
    ;
              
namespace_or_type_name 
    : (IDENTIFIER) ('.' IDENTIFIER)*
    ;

simple_embedded_statement
    : ';'
    | expression ';'? 
    | IF LPAREN expression RPAREN if_body (ELSE if_body)?
    | WHILE LPAREN expression RPAREN embedded_statement
    | DO embedded_statement WHILE LPAREN expression RPAREN
    | FOR LPAREN for_initializer? ';' expression? ';' for_iterator? RPAREN embedded_statement
    | FOREACH LPAREN type IDENTIFIER IN expression RPAREN embedded_statement
    | GOTO IDENTIFIER
    | BREAK 
    | CONTINUE
    ;

fragmented_statement_if
    : IF LPAREN expression RPAREN OPEN_BRACE
    ;

fragmented_statement
    : WHILE LPAREN expression RPAREN OPEN_BRACE
    | FOR LPAREN for_initializer? ';' expression? ';' for_iterator? RPAREN OPEN_BRACE
    | FOREACH LPAREN type IDENTIFIER IN expression RPAREN OPEN_BRACE
    ;

for_initializer
    : local_variable_declaration
    | expression (','  expression)*
    ;

for_iterator
    : expression (','  expression)*
    ;

expression
    : assign                                          # AssignExpression
    | expression op=(INC|DEC)                         # PrimaryExpression
    | op=(PLUS|MINUS|INC|DEC) expression              # UnaryExpression
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
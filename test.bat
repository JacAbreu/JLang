@echo off

echo compiling the lexer ...
call antlr JLangLexer.g4
echo compiling the parser ...
call antlr JLangParser.g4
echo building ...
call javac JLang*.java

echo.

for %%F in (samples\*.j) do (
    echo testing "%%F" ...
    call grun JLang template -tree "%%F" > output.temp
)

echo done.
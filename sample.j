<%
    if (a > b) {
        min = a;
        max = b;
    }
    else if (b <= a)
    {
        min = b;
        max = a;
    }      
%>
<% 
    a = 10 - (true ? -2 : 2)
%>
Now a value from a expression <?a+2?> 
Yeah!!


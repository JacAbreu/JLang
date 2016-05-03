<%
for (int i = 0; i < 10; i++)
{
%>
<? i ?> é <% if (i%2==0) { %> par <% } else { %> impar <% } %>
<%
}
%>
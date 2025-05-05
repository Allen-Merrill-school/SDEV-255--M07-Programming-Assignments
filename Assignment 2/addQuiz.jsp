//Confused but used stackoverflow, youtube, and ai to complete correctly I think
<%@ page import="java.util.*, java.io.*" %>
<%
    final int TOTAL_QUESTIONS = 10;
    String[] userAnswers = request.getParameterValues("answer");
    String result = "";
    int correctCount = 0;

    if (userAnswers == null) {
        // First visit: Generate quiz questions
        Random rand = new Random();
        int[] numbers1 = new int[TOTAL_QUESTIONS];
        int[] numbers2 = new int[TOTAL_QUESTIONS];

        for (int i = 0; i < TOTAL_QUESTIONS; i++) {
            numbers1[i] = rand.nextInt(50); // 0 to 49
            numbers2[i] = rand.nextInt(50); // 0 to 49
        }

        // Store the numbers in hidden fields for checking later
%>
<html>
<head><title>Addition Quiz</title></head>
<body>
<h2>Addition Quiz</h2>
<form method="post">
<%
        for (int i = 0; i < TOTAL_QUESTIONS; i++) {
%>
    <%= numbers1[i] %> + <%= numbers2[i] %> = 
    <input type="text" name="answer" size="3" />
    <input type="hidden" name="num1" value="<%= numbers1[i] %>" />
    <input type="hidden" name="num2" value="<%= numbers2[i] %>" />
    <br/>
<% 
        }
%>
    <br/>
    <input type="submit" value="Submit" />
</form>
</body>
</html>
<%
    } else {
        // Second visit: Process results
        String[] num1 = request.getParameterValues("num1");
        String[] num2 = request.getParameterValues("num2");

%>
<html>
<head><title>Quiz Results</title></head>
<body>
<h2>Quiz Results</h2>
<%
        for (int i = 0; i < TOTAL_QUESTIONS; i++) {
            int n1 = Integer.parseInt(num1[i]);
            int n2 = Integer.parseInt(num2[i]);
            int correctAnswer = n1 + n2;
            int userAnswer = 0;

            try {
                userAnswer = Integer.parseInt(userAnswers[i]);
            } catch (NumberFormatException e) {
                // Invalid input counts as wrong
            }

            if (userAnswer == correctAnswer) {
                result = "Correct";
                correctCount++;
            } else {
                result = "Wrong";
            }

            out.println(n1 + " + " + n2 + " = " + userAnswers[i] + " " + result + "<br/>");
        }

        out.println("<br/>The total correct count is " + correctCount);
%>
</body>
</html>
<%
    }
%>

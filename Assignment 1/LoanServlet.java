import javax.servlet.*;
import javax.rvlet.http.*;
import java.io.*;

public class LoanServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //Retrieve form parameters
        double loanAmount = Double.parseDouble(request.getParameter("loanAmount"));
        double annualInterestRate = Double.parseDouble(request.getParameter("interestRate"));
        int years = Integer.parseInt(request.getParameter("years"));

        //Calculate loan 
        double monthlyInterestRate = annualInterestRate / 1200;
        int numberOfPayments = years * 12;
        double monthlyPayment = (loanAmount * monthlyInterestRate) / (1 - Math.pow(1 + monthlyInterestRate, -numberOfPayments));
        double totalPayment = monthlyPayment * numberOfPayments;

        //Display results
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        out.println("<html><body>");
        out.println("<h2>Loan Payment Results</h2>");
        out.println("Monthly Payment: $" + String.format("%.2f", monthlyPayment) + "<br/>");
        out.println("Total Payment: $" + String.format("%.2f", totalPayment) + "<br/>");
        out.println("</body></html>");
    }
}

package xmlrpc.handlers;

public class FactImpl implements Fact {
    public int fact(int n) {
        System.out.println("Received : " + n);
        int prod = 1;
        for (int i = 2; i <= n; i++)
            prod *= i;
        System.out.println("Sent : " + prod);
        return prod;
    }
}

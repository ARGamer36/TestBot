import javax.security.auth.login.LoginException;

public class TestBotDriver extends TestBot {
    public TestBotDriver() throws LoginException {
        super();
    }
    public static void main(String[] args) {
        try {
            TestBot bot = new TestBot();
        } catch (LoginException e) {
            System.out.println("ERROR: provided bot token is invalid");
        }
    }
}

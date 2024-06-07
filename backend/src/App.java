import controller.CardController;
import webserver.WebServer;
import webserver.WebServerContext;

public class App {
    public static void main(String[] args) throws Exception {
        try {
            WebServer webserver = new WebServer();
            webserver.listen(8080);
            webserver.getRouter().get(
                "/cards", 
                (WebServerContext context) -> { CardController.findAll(context); }
            );
        } 
        catch (Exception e) {}
    }
}
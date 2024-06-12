import controller.CardController;
import controller.PartController;
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
            webserver.getRouter().post(
                "/part", 
                (WebServerContext context) -> { 
                    System.out.println("Handling /part post request");
                    PartController.insertNewPart(context); }
            );
            webserver.getRouter().get(
                "/part", 
                (WebServerContext context) -> { 
                    System.out.println("Handling /part get request");
                    PartController.ResponsePart(context); }
            );

        } 
        catch (Exception e) {}
    }
}
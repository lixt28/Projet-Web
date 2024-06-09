import controller.WordController;
import controller.PartController;
import webserver.WebServer;
import webserver.WebServerContext;


public class App {
    public static void main(String[] args) throws Exception {
        try {
            WebServer webserver = new WebServer();
            webserver.listen(8080);
            webserver.getRouter().get(
                "word", 
                (WebServerContext context) -> { WordController.findAll(context); }
            );
            
            webserver.getRouter().get(
                "/part", 
                (WebServerContext request) -> { PartController.insertNewPart(request); }
            );
           

        } 
        catch (Exception e) {}
    }
}
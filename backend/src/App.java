import controller.CardController;
import controller.PartController;
import webserver.WebServer;
import webserver.WebServerContext;


public class App {
    public static void main(String[] args) throws Exception {
        try {
            WebServer webserver = new WebServer();
            webserver.listen(8080);

            //Route pour envoyer la liste des cards de la base de donnees
            webserver.getRouter().get(
                "/cards", 
                (WebServerContext context) -> { CardController.findAll(context); }
            );

            //Route pour recuperer les donnees pour creer et  rejoindre une partie
            webserver.getRouter().post(
                "/part", 
                (WebServerContext request) -> { 
                    System.out.println("Handling /part post request ");
                    PartController.insertNewPart(request); }
            );
            

        } 
        catch (Exception e) {}
    }
}
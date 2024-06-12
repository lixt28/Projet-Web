package controller;

import dao.PartDAO;
import models.Part;
import webserver.WebServerContext;


public class PartController {
    public static void insertNewPart(WebServerContext request) {
        if (request.getRequest().getMethod().equals("POST") && request.getRequest().getPath().equals("/part")) {
            // Récupérer les données de la partie à partir du corps de la requête
            Part partData = request.getRequest().extractBody(Part.class);
            System.out.println("Name: " + partData.name());
            System.out.println("Role: " + partData.role());
            System.out.println("Part Code: " + partData.partCode());
            // Insérer les données de la partie dans la base de données
            PartDAO partDAO = new PartDAO();
            if(partData.role().equals("mj")){
                partDAO.insertPart(partData);
            }else{
                partDAO.jointPart(partData);
            }

            // Répondre à la requête avec un message de succès
            request.getResponse().json("{\"message\": \"Partie créée avec succès\"}");
        }
    }

}


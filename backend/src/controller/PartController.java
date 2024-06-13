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
            System.out.println(" Is Not Game Creator : " + partData.IsnotcreatorOfGame());
            
            // Insérer les données de la partie dans la base de données
            PartDAO partDAO = new PartDAO();
            
           String PartMessage;

            if(partData.IsnotcreatorOfGame().equals("false")){
                PartMessage = partDAO.insertPart(partData);
                
            }else{

                PartMessage  = partDAO.jointPart(partData); 
            }
            String jsonResponse = String.format("{\"message\": \"%s\", \"partCode\": \"%s\", \"role\": \"%s\"}",PartMessage,partData.partCode(),partData.role());
            request.getResponse().json(jsonResponse);

            
            
        }
    }

    
}


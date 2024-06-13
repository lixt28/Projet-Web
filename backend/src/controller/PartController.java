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
            
           String partMessage;
           

            if(partData.IsnotcreatorOfGame().equals("false")){
                partMessage = partDAO.insertPart(partData);
                
            }else{

                partMessage  = partDAO.jointPart(partData); 
            }
           

            if(partData.role().equals(""))
            {
                int index = partMessage.indexOf(",");
                if (index != -1)
                {
                    String firstPart = partMessage.substring(0, index);
                    String secondPart = partMessage.substring(index + 1);
                    System.out.println("Première partie : " + firstPart);
                    System.out.println("Deuxième partie : " + secondPart);
                
                    String jsonResponse = String.format("{\"message\": \"%s\", \"partCode\": \"%s\", \"role\": \"%s\"}",firstPart,partData.partCode(),secondPart);
                    request.getResponse().json(jsonResponse);
                }
            }else{
                int index = partMessage.indexOf(",");
                if (index != -1)
                {
                    String firstPart = partMessage.substring(0, index);
                    String secondPart = partMessage.substring(index + 1);
                    System.out.println("Première partie : " + firstPart);
                    System.out.println("Deuxième partie : " + secondPart);
                
                    String jsonResponse = String.format("{\"message\": \"%s\", \"partCode\": \"%s\", \"role\": \"%s\"}",firstPart,partData.partCode(),partData.role());
                    request.getResponse().json(jsonResponse);
                }
    
            }

           

            
            
        }
    }

    
}


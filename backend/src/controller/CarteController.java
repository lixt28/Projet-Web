package controller;
import java.util.ArrayList;
import dao.CarteDAO;
import models.Carte;
import webserver.WebServerContext;

public class CarteController {
    public static void findAll(WebServerContext context) {
        CarteDAO productsDAO = new CarteDAO();
        ArrayList<Carte> listOfProducts = productsDAO.findAll();
        context.getResponse().json(listOfProducts);
    }
}



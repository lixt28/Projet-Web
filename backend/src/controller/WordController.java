package controller;
import java.util.ArrayList;
import dao.WordDAO;
import models.Word;
import webserver.WebServerContext;


public class WordController {
    public static void findAll(WebServerContext context) {
        WordDAO productsDAO = new WordDAO();
        ArrayList<Word> listOfProducts = productsDAO.findAll();
        context.getResponse().json(listOfProducts);
    }
}




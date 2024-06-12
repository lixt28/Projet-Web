package controller;
import java.util.ArrayList;
import dao.CardDAO;
import models.Card;
import webserver.WebServerContext;

public class CardController {
    public static void findAll(WebServerContext context) {
        CardDAO CardDAO = new CardDAO();
        ArrayList<Card> CardsList = CardDAO.findAll();
        context.getResponse().json(CardsList);
    }
}
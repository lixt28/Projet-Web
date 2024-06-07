package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import database.PolyNamesDatabase;
import models.Card;

public class CardDAO {
    public ArrayList<Card> findAll() {
        ArrayList<Card> cardsList = new ArrayList<>();
        try {
            PolyNamesDatabase connexion = new PolyNamesDatabase();
            PreparedStatement statement = connexion.prepareStatement("SELECT * FROM word");
            ResultSet results = statement.executeQuery();

            while (results.next()) {
                String word = results.getString("word");
                int color_id = results.getInt("color_id");

                PreparedStatement color_request = connexion.prepareStatement("SELECT * FROM color WHERE color_id=?");
                color_request.setInt(1,color_id);
                ResultSet color_results = color_request.executeQuery();

                if(color_results.next()) {
                    String color_name = color_results.getString("color_name");
                    Card newCard = new Card(word,color_name);
                    cardsList.add(newCard);
                }
            }
        }
        catch (SQLException e){}
        return cardsList;
    }
}

package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import database.PolyNamesDatabase;
import models.Word;

public class WordDAO {
    public ArrayList<Word> findAll() {
        ArrayList<Word> listOfCartes = new ArrayList<>();
        try {
            PolyNamesDatabase connexion = new PolyNamesDatabase();
            PreparedStatement statement = connexion.prepareStatement("SELECT * FROM word");
            ResultSet results = statement.executeQuery();

            while (results.next()) {
                int id = results.getInt("word_id");
                String name = results.getString("word");

                PreparedStatement requestcouleur = connexion.prepareStatement("SELECT * FROM color where color_id=?");
                requestcouleur.setInt(1,id);
                ResultSet result_couleur = requestcouleur.executeQuery();
                
                if(result_couleur.next())
                {
                    String color_name = result_couleur.getString("color_name");
                    Word newCarte = new Word(color_name, name);
                    listOfCartes.add(newCarte);
                }
               
            }
        }
        catch (SQLException e){}
        return listOfCartes;
    }
}

package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import database.PolyNamesDatabase;
import models.Carte;

public class CarteDAO {
    public ArrayList<Carte> findAll() {
        ArrayList<Carte> listOfCartes = new ArrayList<>();
        try {
            PolyNamesDatabase connexion = new PolyNamesDatabase();
            PreparedStatement statement = connexion.prepareStatement("SELECT * FROM carte");
            ResultSet results = statement.executeQuery();

            while (results.next()) {
                int id = results.getInt("id");
                String name = results.getString("name");
                Carte newCarte = new Carte(id, name);
                listOfCartes.add(newCarte);
            }
        }
        catch (SQLException e){}
        return listOfCartes;
    }
}

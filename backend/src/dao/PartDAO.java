package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import database.PolyNamesDatabase;
import models.Part;

public class PartDAO {

    public void insertPart(Part part) {
        try {
            PolyNamesDatabase connexion = new PolyNamesDatabase();
            String sql = "INSERT INTO game (game_code) VALUES (?)";
            PreparedStatement statement = connexion.prepareStatement(sql);
            statement.setString(1, part.partCode());
            statement.executeQuery();

            String sql1 = "INSERT INTO player (name) VALUES (?)";
            PreparedStatement statement1 = connexion.prepareStatement(sql1);
            statement1.setString(1, part.name());
            statement1.executeQuery();


            String sql2 = "SELECT game_id from game where game_code = ?";
            PreparedStatement statement2 = connexion.prepareStatement(sql2);
            statement2.setString(1, part.partCode());
            ResultSet results = statement2.executeQuery();
            int game_id = results.getInt("game_id");


            String sql3 = "SELECT player_id from player where name = ?";
            PreparedStatement statement3 = connexion.prepareStatement(sql3);
            statement3.setString(1, part.name());
            ResultSet results1 = statement3.executeQuery();
            int player_id = results1.getInt("player_id");



            String sql4 = "INSERT INTO participate (game_id,player_id,role) VALUES (?,?,?)";
            PreparedStatement statement4 = connexion.prepareStatement(sql4);
            statement4.setInt(1, game_id);
            statement4.setInt(2, player_id);
            statement4.setString(3, part.role());
            statement4.executeQuery();
           
           
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

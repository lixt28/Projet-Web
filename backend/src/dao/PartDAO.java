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
            int results = statement.executeUpdate();

            String sql1 = "INSERT INTO player (name) VALUES (?)";
            PreparedStatement statement1 = connexion.prepareStatement(sql1);
            statement1.setString(1, part.name());
            int results1 =  statement1.executeUpdate();

            String sql2 = "SELECT LAST_INSERT_ID() ";
            PreparedStatement statement2 = connexion.prepareStatement(sql2);
            //statement3.setString(1, part.name());
            ResultSet results2 = statement2.executeQuery();
            int player_id = 0;
            if (results2.next()) {
                player_id = results2.getInt("player_id");
            }


            String sql3 = "SELECT game_id from game where game_code = ?";
            PreparedStatement statement3 = connexion.prepareStatement(sql3);
            statement3.setString(1, part.partCode());
            ResultSet results3 = statement3.executeQuery();
            int game_id = 0;
            if (results3.next()) {
                game_id = results3.getInt("game_id");
            }

           

            String sql4 = "INSERT INTO participate (game_id,player_id,role) VALUES (?,?,?)";
            PreparedStatement statement4 = connexion.prepareStatement(sql4);
            statement4.setInt(1, game_id);
            statement4.setInt(2, player_id);
            statement4.setString(3, part.role());
            int rowsAffectedParticipate = statement4.executeUpdate();
           
           // Vérification des insertions et affichage des messages de succès ou d'erreur
                if (results> 0 && results1 > 0 && rowsAffectedParticipate > 0) {
                    System.out.println("Insertion réussie des informations du createur de la partie   !");
                } else {
                    System.out.println("Erreur lors de l'insertion des informations du createur de la partie .");
                }
                    
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void jointPart(Part partData) {
        try{
            String name = partData.name();
            String partCode = partData.partCode();

            PolyNamesDatabase connexion = new PolyNamesDatabase();


            String sql1 = "INSERT INTO player (name) VALUES (?)";
            PreparedStatement statement1 = connexion.prepareStatement(sql1);
            statement1.setString(1, name);
            int results1 =  statement1.executeUpdate();


           
            String sql2 = "SELECT SELECT LAST_INSERT_ID();";
            PreparedStatement statement2 = connexion.prepareStatement(sql2);
            //statement3.setString(1, part.name());
            ResultSet results2 = statement2.executeQuery();
            int player2_id = 0;
            if (results2.next()) {
                player2_id = results2.getInt("player_id");
            }


            String sql3 = "SELECT game_id from game where game_code = ?";
            PreparedStatement statement3 = connexion.prepareStatement(sql3);
            statement3.setString(1, partCode);
            ResultSet results3 = statement3.executeQuery();
            int game_id = 0;
            if (results3.next()) {
                game_id = results3.getInt("game_id");
            }

            String sql4 = "SELECT * FROM participate WHERE game_id = ? ";
            PreparedStatement statement4 = connexion.prepareStatement(sql4);
            statement4.setInt(1, game_id);
            ResultSet results4 = statement4.executeQuery();
            String PartCreatorRole = "null";
            if (results4.next()) {
                PartCreatorRole  =  results4.getString("role");
            }

            if(PartCreatorRole == "mi")
            { 
                partData.updateRole("mj") ; 
            }else{
                partData.updateRole("mi");
            }

            


            String sql5 = "INSERT INTO participate (game_id,player_id,role) VALUES (?,?,?)";
            PreparedStatement statement5 = connexion.prepareStatement(sql5);
            statement5.setInt(1, game_id);
            statement5.setInt(2, player2_id);
            statement5.setString(3, partData.role());
            int results5 = statement5.executeUpdate();
           
           // Vérification des insertions et affichage des messages de succès ou d'erreur
                if (results1 > 0 && results5> 0 ) {
                    System.out.println("Insertion réussie des informations du joueur qui rejoins la partie !");
                } else {
                    System.out.println("Erreur lors de l'insertion des informations du joueur qui rejoins la partie  .");
                }
                    
        } catch (SQLException e) {
            e.printStackTrace();
        }
    
    }
}

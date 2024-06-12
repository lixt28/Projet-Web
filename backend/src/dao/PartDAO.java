package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import database.PolyNamesDatabase;
import models.Part;

public class PartDAO {

    public void insertPart(Part part) {
        try {
            
            PolyNamesDatabase connexion = new PolyNamesDatabase();

            String sql = "INSERT INTO game (game_code) VALUES (?)";
            PreparedStatement statement = connexion.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            statement.setString(1, part.partCode());
            int rowsAffectedGame = statement.executeUpdate();
            int gameId = 0;
            ResultSet rs = statement.getGeneratedKeys();
            if (rs.next()) {
                gameId = rs.getInt(1);
            }

            String sql1 = "INSERT INTO player (name) VALUES (?)";
            PreparedStatement statement1 = connexion.prepareStatement(sql1, Statement.RETURN_GENERATED_KEYS);
            statement1.setString(1, part.name());
            int rowsAffectedPlayer =  statement1.executeUpdate();
            int playerId =0;
            ResultSet rs1 = statement1.getGeneratedKeys();
            if (rs1.next()) {
                playerId = rs1.getInt(1);
            }
          
            String sql2 = "INSERT INTO participate (game_id,player_id,role) VALUES (?,?,?)";
            PreparedStatement statement2 = connexion.prepareStatement(sql2);
            statement2.setInt(1, gameId);
            statement2.setInt(2, playerId);
            statement2.setString(3, part.role());
            int rowsAffectedParticipate = statement2.executeUpdate();
           
           // Vérification des insertions et affichage des messages de succès ou d'erreur
                if (rowsAffectedGame> 0 && rowsAffectedPlayer > 0 && rowsAffectedParticipate > 0) {
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
            PreparedStatement statement1 = connexion.prepareStatement(sql1,Statement.RETURN_GENERATED_KEYS);
            statement1.setString(1, name);
            int rowsAffectedPlayer =  statement1.executeUpdate();
            ResultSet rs1 = statement1.getGeneratedKeys();
            int player2_Id = 0;
            if (rs1.next()) {
                player2_Id = rs1.getInt(1);
            }


           

            String sql2 = "SELECT game_id from game where game_code = ?";
            PreparedStatement statement2 = connexion.prepareStatement(sql2);
            statement2.setString(1, partCode);
            ResultSet results2 = statement2.executeQuery();
            int gameId = 0;
            if (results2.next()) {
                gameId = results2.getInt("game_id");
            }

            String sql3 = "SELECT * FROM participate WHERE game_id = ? ";
            PreparedStatement statement3 = connexion.prepareStatement(sql3);
            statement3.setInt(1, gameId);
            ResultSet results3 = statement3.executeQuery();
            String PartCreatorRole = "null";
            if (results3.next()) {
                PartCreatorRole  =  results3.getString("role");
            }

            if(PartCreatorRole.equals("mi"))
            { 
                partData = partData.updateRole("mj") ; 
            }else{
                partData = partData.updateRole("mi");
            }

            
            String newRole = partData.role();

            String sql4 = "INSERT INTO participate (game_id,player_id,role) VALUES (?,?,?)";
            PreparedStatement statement4 = connexion.prepareStatement(sql4);
            statement4.setInt(1, gameId);
            statement4.setInt(2, player2_Id);
            statement4.setString(3, newRole);
            int results4 = statement4.executeUpdate();
           
           // Vérification des insertions et affichage des messages de succès ou d'erreur
                if (rowsAffectedPlayer > 0 && results4> 0 ) {
                    System.out.println("Insertion réussie des informations du joueur qui rejoins la partie !");
                } else {
                    System.out.println("Erreur lors de l'insertion des informations du joueur qui rejoins la partie  .");
                }
                    
        } catch (SQLException e) {
            e.printStackTrace();
        }
    
    }
}

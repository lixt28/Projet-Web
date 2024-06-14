package dao;


import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


import database.PolyNamesDatabase;


import models.Part;

public class PartDAO {
    String GMNotifier = "Good luck ! you are Game Master,GM";
    String MINotifier = "Good luck ! you are Master of Intuitions,MI";
    String toMuchPlayerNotifier = "Can't reach the game because to much player already,";
    String errorInformationPlayer = "Error inserting the game creator's information,";

    //Fonction de verification s'il existe moins de joueurs associé a une partie
    private boolean VerificationNumberPart(int gameId) {
        boolean canJoin = false; 
        
        try {
            PolyNamesDatabase connexion = new PolyNamesDatabase(); 
    
            String sql = "SELECT COUNT(*) AS player_count FROM participate WHERE game_id = ?";
            PreparedStatement statement = connexion.prepareStatement(sql);
            statement.setInt(1, gameId);
            ResultSet rs = statement.executeQuery();
            
            if (rs.next()) {
                int count = rs.getInt("player_count");
                if (count < 2) {
                    canJoin = true;
                    System.out.println(toMuchPlayerNotifier);
                }
            }
            
            rs.close(); 
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return canJoin;
    }
    

    //Fonction pour inserer les informations du createur de la partie
    public String insertPart(Part part) {
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
                    if(part.role().equals("GM"))
                    { 
                        return  GMNotifier;
                    }else{
                        return  MINotifier;
                    }
                    
                } else {
                    System.out.println(errorInformationPlayer);
                    return errorInformationPlayer;
                }
                    
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return toMuchPlayerNotifier;
    }

    //Fonction pour inserer les informations de celui qui rejoins la partie
    public String jointPart(Part partData) {
        String Message = "";
        try{
            
            String name = partData.name();
            String partCode = partData.partCode();

            PolyNamesDatabase connexion = new PolyNamesDatabase();



           

            String sql1 = "SELECT game_id from game where game_code = ?";
            PreparedStatement statement1 = connexion.prepareStatement(sql1);
            statement1.setString(1, partCode);
            ResultSet results1 = statement1.executeQuery();
            int gameId = 0;
            if (results1.next()) {
                gameId = results1.getInt("game_id");
            }

            // Vérification du nombre de joueur relié  au code de la partie entrée 
            if (VerificationNumberPart(gameId)) {
             
            String sql2 = "INSERT INTO player (name) VALUES (?)";
            PreparedStatement statement2 = connexion.prepareStatement(sql2,Statement.RETURN_GENERATED_KEYS);
            statement2.setString(1, name);
            int rowsAffectedPlayer =  statement2.executeUpdate();
            ResultSet rs2 = statement2.getGeneratedKeys();
            int player2_Id = 0;
            if (rs2.next()) {
                player2_Id = rs2.getInt(1);
            }


            String sql3 = "SELECT * FROM participate WHERE game_id = ? ";
            PreparedStatement statement3 = connexion.prepareStatement(sql3);
            statement3.setInt(1, gameId);
            ResultSet results3 = statement3.executeQuery();
            String PartCreatorRole = "null";
            if (results3.next()) {
                PartCreatorRole  =  results3.getString("role");
            }

            if(PartCreatorRole.equals("MI"))
            { 
                partData = partData.updateRole("GM") ; 
            }else{
                partData = partData.updateRole("MI");
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
                    if(newRole.equals("GM"))
                    { 
                        Message = GMNotifier;
                    }else{
                        Message =  MINotifier;
                    }
                } else {
                    Message =  errorInformationPlayer;
                }
        }else {
            System.out.println(toMuchPlayerNotifier);
            return toMuchPlayerNotifier;
        }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return  Message ;
    
    }
}

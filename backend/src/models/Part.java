package models;

public record Part(
    String name,
    String role,
    String partCode,
    String IsnotcreatorOfGame
) {

    public Part updateRole(String newRole) {
        return new Part(this.name(), newRole,this.partCode(),this.IsnotcreatorOfGame());
    }
}


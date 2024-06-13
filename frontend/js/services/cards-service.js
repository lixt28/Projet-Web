export class CardsService {
    static async findAll() {
        const response = await fetch("http://localhost:8080/cards");

        if(response.status === 200){
            const data = await response.json();
            return data;
        }
    }
}
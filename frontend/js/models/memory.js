import { Card } from "./card.js";

export class Memory {
    #cards;

    constructor() {
        this.#cards = [];
    }

    newGame(cardNumber) {
        this.#cards = [];
    
        const words = [
            "apple", "banana", "cherry", "date", "fig",
            "grape", "kiwi", "lemon", "mango", "nectarine",
            "orange", "papaya", "quince", "raspberry", "strawberry",
            "tangerine", "ugli", "vanilla", "watermelon", "xigua",
            "yam", "zucchini", "plum", "pear", "peach"
        ];

        const colors = [
            "blue","blue","blue","blue","blue","blue","blue","blue",
            "gray","gray","gray","gray","gray","gray","gray","gray","gray","gray","gray","gray","gray","gray","gray",
            "black","black"
        ];

        function shuffle(array) {
            let currentIndex = array.length;
          
            while (currentIndex != 0) {
              let randomIndex = Math.floor(Math.random() * currentIndex);
              currentIndex--;
              [array[currentIndex], array[randomIndex]] = [
                array[randomIndex], array[currentIndex]];
            }
        }

        shuffle(words);
        shuffle(colors);

        for (let i = 0; i < cardNumber; i++) {
            this.#cards.push(new Card(words[i], colors[i]));
        }
    }
    
    get CardsNumber() {
        return this.#cards.length;
    }

    getCard(index) {
        if (index >= 0 && index < this.CardsNumber) {
            return this.#cards[index];
        } else {
            return null;
        }
    }

    toData() {
        return { cards: this.#cards.map(card => ({ value: card.value, color: card.color })) };
    }

    fromData(data) {
        if (data && data.cards && Array.isArray(data.cards)) {
            this.#cards = data.cards.map(cardData => new Card(cardData.value, cardData.color));
        } else {
            console.error('Invalid data format.');
        }
    }
}

import { CartesService } from "../services/cartes-service.js";
import { Card } from "./card.js";

export class Memory {
    #cards;

    constructor() {
        this.#cards = [];
    }

    shuffle(array) {
        let currentIndex = array.length;
      
        while (currentIndex != 0) {
          let randomIndex = Math.floor(Math.random() * currentIndex);
          currentIndex--;
          [array[currentIndex], array[randomIndex]] = [
            array[randomIndex], array[currentIndex]];
        }
        
        return array;
    }

    isValuePresentAtLeastNTimes(array, value, n) {
        let counter = 0;
        for (let i = 0; i < array.length; i++) {
            if (array[i] === value) {
                counter++;
                if (counter >= n) {
                    return true;
                }
            }
        }
        return false;
    }
      
    async getCards() {
        const cartes = await CartesService.findAll();
        return cartes;
    }

    async newGame(cardNumber) {
        this.#cards = [];
        const words = [];
        const colors = [];
    
        const word_table = await this.getCards();
        const shuffledWords = this.shuffle(word_table);

        shuffledWords.forEach(word => {
            if (words.indexOf(word.word) === -1) {
                words.push(word.word);
                if (word.color === "Blue" && !this.isValuePresentAtLeastNTimes(colors, word.color, 8)) {
                    colors.push(word.color);
                } else if (word.color === "Gray" && !this.isValuePresentAtLeastNTimes(colors, word.color, 15)) {
                    colors.push(word.color);
                } else if (word.color === "Black" && !this.isValuePresentAtLeastNTimes(colors, word.color, 2)) {
                    colors.push(word.color);
                }
            }
            
        });

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
        return { cards: this.#cards.map(card => ({ word: card.word, color: card.color })) };
    }

    fromData(data) {
        if (data && data.cards && Array.isArray(data.cards)) {
            this.#cards = data.cards.map(cardData => new Card(cardData.word, cardData.color));
        } else {
            console.error('Invalid data format.');
        }
    }
}

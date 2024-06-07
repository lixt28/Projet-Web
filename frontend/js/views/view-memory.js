import { Observer } from "../patterns/observer.js";

export class ViewMemory extends Observer {
    #controllerMemory;

    constructor(controllerMemory) {
        super();

        this.#controllerMemory = controllerMemory;
        this.#controllerMemory.addObserver(this);
    }

    notify() {
        this.displayCards();
    }

    displayCards() {
        const cardsContainer = document.querySelector(".cards");
        cardsContainer.innerHTML = '';
        const cardsNumber = this.#controllerMemory.memory.CardsNumber;
        for (let i = 0; i < cardsNumber; i++) {
            const card = this.#controllerMemory.memory.getCard(i);
            this.displayCard(card);
        }
    }

    displayCard(card) {
        const newCard = document.createElement("div");
        newCard.classList.add("card");
        newCard.dataset.color = card.color;
        newCard.textContent = card.word;
    
        newCard.addEventListener("click", () => {
            newCard.style.backgroundColor = newCard.dataset.color;
        });
    
        document.querySelector(".cards").appendChild(newCard);
    }
    
    
}

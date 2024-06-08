import { Observer } from "../patterns/observer.js";

export class ViewMemory extends Observer {
    #controllerMemory;
    #hintActive = true;
    #roundActive = false;
    #counterTotalBlue = 0;
    #counter = 0;

    constructor(controllerMemory) {
        super();

        this.#controllerMemory = controllerMemory;
        this.#controllerMemory.addObserver(this);

        this.setupEventListeners();
    }

    setupEventListeners() {
        document.getElementById("submitHint").addEventListener("click", (event) => {
            if (this.#hintActive === true) {
                event.preventDefault();

                const hintValue = document.getElementById("hint").value;
                const nValue = document.getElementById("n").value;

                document.getElementById("hintText").textContent = hintValue;
                document.getElementById("hintN").textContent = nValue;

                const roundNumberElement = document.getElementById("roundNumber");
                let roundNumber = parseInt(roundNumberElement.textContent);
                roundNumber++;
                roundNumberElement.textContent = roundNumber;

                this.#hintActive = false;
                this.#roundActive = true;
            }
        });
    }

    notify() {
        this.displayCards();
        this.displayPlayers();
        this.round();
    }

    displayCards() {
        const cardsContainer = document.querySelector(".cards");
        cardsContainer.innerHTML = '';
        const cardsNumber = this.#controllerMemory.memory.CardsNumber;
        for (let i = 0; i < cardsNumber; i++) {
            const card = this.#controllerMemory.memory.getCard(i);
            if (localStorage.getItem("playerRole") === "GM") {
                this.displayCardForGM(card);
            } else if (localStorage.getItem("playerRole") === "MI") {
                this.displayCardForMI(card);
            }
        }
    }

    displayCardForGM(card) {
        const newCard = document.createElement("div");
        newCard.classList.add("card");
        newCard.textContent = card.word;

        if (card.color === "Blue") {
            newCard.classList.add("blue");
        } else if (card.color === "Gray") {
            newCard.classList.add("gray");
        } else if (card.color === "Black") {
            newCard.classList.add("black");
        }

        document.querySelector(".cards").appendChild(newCard);
    }

    displayCardForMI(card) {
        const newCard = document.createElement("div");
        newCard.classList.add("card", "hidden");
        newCard.textContent = card.word;

        if (card.color === "Blue") {
            newCard.classList.add("blue");
        } else if (card.color === "Gray") {
            newCard.classList.add("gray");
        } else if (card.color === "Black") {
            newCard.classList.add("black");
        }

        newCard.addEventListener("click", () => {
            if (this.#roundActive === true) {
                this.roundScore(newCard);
            }
        });

        document.querySelector(".cards").appendChild(newCard);
    }

    displayPlayers() {
        const playerName = localStorage.getItem("playerName");

        if (localStorage.getItem("playerRole") === "GM") {
            document.getElementById("player_1").textContent = playerName;
        }
        if (localStorage.getItem("playerRole") === "MI") {
            document.getElementById("player_2").textContent = playerName;
        }
    }

    round() {
        if (this.#roundActive === true) {
            document.querySelectorAll('.card').forEach(card => {
                card.addEventListener("click", () => {
                    this.roundScore(card);
                });
            });
        }
    }

    roundScore(card) {
        const roundScoreElement = document.getElementById("roundScore");
        let roundScore = parseInt(roundScoreElement.textContent);
        const n = parseInt(document.getElementById("hintN").textContent);

        if (card.classList.contains("hidden")) {
            card.classList.remove("hidden");
            card.classList.add("revealed");

            if (card.classList.contains("blue")) {
                this.#counterTotalBlue++;
                this.#counter++;

                if (this.#counter > n) {
                    roundScore += Math.pow(this.#counter, 2);
                    this.#roundActive = false;
                    this.#hintActive = true;
                    this.#counter = 0;
                } else {
                    roundScore += this.#counter;
                }
                if(this.#counterTotalBlue === 8) {
                    this.win(roundScore);
                    return;
                } 
            } else if (card.classList.contains("gray")) {
                this.#roundActive = false;
                this.#hintActive = true;
            } else if (card.classList.contains("black")) {
                this.gameOver(roundScore);
                return;
            }
            
            roundScoreElement.textContent = roundScore;
        }
    }

    gameOver(score) {
        // Redirige vers la page "game_over.html" avec le score final comme paramètre d'URL
        window.location.href = `game_over.html?score=${score}`;
    }

    win(score) {
        // Affiche la page de victoire avec le score final
        window.location.href = `win.html?score=${score}`;
    }
}

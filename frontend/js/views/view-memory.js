import { Observer } from "../patterns/observer.js";

export class ViewMemory extends Observer {
    #controllerMemory;
    #hintActive = true;
    #roundActive = false;
    #counterTotalBlue = 0;
    #counter = 0;
    #roundNumber = 0;

    constructor(controllerMemory) {
        super();
        this.#controllerMemory = controllerMemory;
        this.#controllerMemory.addObserver(this);
        this.setNewHint();
        this.updateHint();
    }

    notify() {
        this.displayCards();
        this.displayPlayers();
        this.setNewHint();
        this.updateHint();
        this.newRound();
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

    // setNewHint() {
    //     if(localStorage.getItem("hintActive")) { this.#hintActive = localStorage.getItem("hintActive"); }
    //     if(localStorage.getItem("roundActive")) { this.#roundActive = localStorage.getItem("roundActive"); }
    //     if(localStorage.getItem("roundNumber")) { this.#roundNumber = localStorage.getItem("roundNumber"); }
    
    //     console.log(this.#hintActive);
    
    //     if(localStorage.getItem("playerRole") === "GM") {
    //         const submitHintButton = document.getElementById("submitHint");
    //         const submitHintHandler = (event) => {
    //             if (this.#hintActive === true) {
                    
    //                 event.preventDefault();
    
    //                 const nValue = document.getElementById("n").value;
    //                 const hintValue = document.getElementById("hint").value;
    
    //                 if (nValue.trim() === "" || hintValue.trim() === "") {
    //                     alert("Warning !! Empty hint or N");
    //                     return;
    //                 }
    
    //                 document.getElementById("hintText").textContent = hintValue;
    //                 document.getElementById("hintN").textContent = nValue;
                    
    //                 const currentRound = document.getElementById("roundNumber");
    //                 let roundNumber = parseInt(currentRound.textContent);
    //                 roundNumber++;
    //                 currentRound.textContent = roundNumber;
    
    //                 localStorage.setItem("nGiven", nValue);
    //                 localStorage.setItem("hintGiven", hintValue);
    //                 localStorage.setItem("currentRound", roundNumber);
    
    //                 console.log("Hint '" + hintValue + "' sent successfully with N = " + nValue);
    //                 console.log("Starting round " + this.#roundNumber);
    
    //                 this.#roundNumber += 1;
    //                 this.#hintActive = false;
    //                 this.#roundActive = true;
    
    //                 localStorage.setItem("hintActive", this.#hintActive);
    //                 localStorage.setItem("roundActive", this.#roundActive);
    //                 localStorage.setItem("roundNumber", this.#roundNumber);
    
    //                 // submitHintButton.disabled = true;
    
    //                 // Supprimer l'écouteur d'événements après soumission des indices
    //                 submitHintButton.removeEventListener("click", submitHintHandler);
    //             }
    //         };
    
    //         submitHintButton.addEventListener("click", submitHintHandler);
    //     }
    //     setTimeout(this.setNewHint.bind(this), 2000);
    // }
    

    setNewHint() {
        if(localStorage.getItem("hintActive")) { this.#hintActive = localStorage.getItem("hintActive"); }
        if(localStorage.getItem("roundActive")) { this.#roundActive = localStorage.getItem("roundActive"); }
        if(localStorage.getItem("roundNumber")) { this.#roundNumber = localStorage.getItem("roundNumber"); }

        console.log(this.#hintActive);

        if(localStorage.getItem("playerRole") === "GM") {
            document.getElementById("submitHint").addEventListener("click", (event) => {
                if (this.#hintActive === true) {
                    
                    event.preventDefault();
    
                    const nValue = document.getElementById("n").value;
                    const hintValue = document.getElementById("hint").value;

                    if (nValue.trim() === "" || hintValue.trim() === "") {
                        alert("Warning !! Empty hint or N");
                        return;
                    }
    
                    document.getElementById("hintText").textContent = hintValue;
                    document.getElementById("hintN").textContent = nValue;
                    
                    const currentRound = document.getElementById("roundNumber");
                    let roundNumber = parseInt(currentRound.textContent);
                    roundNumber++;
                    currentRound.textContent = roundNumber;
    
                    localStorage.setItem("nGiven", nValue);
                    localStorage.setItem("hintGiven", hintValue);
                    localStorage.setItem("currentRound", roundNumber);
    
                    console.log("Hint '" + hintValue + "' sent successfully with N = " + nValue);
                    console.log("Starting round " + this.#roundNumber);
    
                    this.#roundNumber += 1;
                    this.#hintActive = false;
                    this.#roundActive = true;

                    localStorage.setItem("hintActive", this.#hintActive);
                    localStorage.setItem("roundActive", this.#roundActive);
                    localStorage.setItem("roundNumber", this.#roundNumber);

                    document.getElementById("submitHint").disabled = true;

                    return;
                }

                return;
                
            });
            
        }
        setTimeout(this.setNewHint.bind(this), 2000);
    }

    updateHint() {
        if(localStorage.getItem("hintActive")) { this.#hintActive = localStorage.getItem("hintActive"); }
        if(localStorage.getItem("roundActive")) { this.#roundActive = localStorage.getItem("roundActive"); }
        if(localStorage.getItem("roundNumber")) { this.#roundNumber = localStorage.getItem("roundNumber"); }
        
        if (localStorage.getItem("playerRole") === "MI") {
            const hintGiven = localStorage.getItem("hintGiven");
            const nGiven = localStorage.getItem("nGiven");
            const roundNumber = localStorage.getItem("currentRound");

            if(hintGiven && nGiven && roundNumber) {
                document.getElementById("hintText").textContent = hintGiven;
                console.log("Hint '" + hintGiven + "' has been received");

                document.getElementById("hintN").textContent = nGiven;
                console.log("GM thinks '" + hintGiven + "' match with " + nGiven + " words");

                document.getElementById("roundNumber").textContent = roundNumber;
                console.log("Starting round " + roundNumber);
            }
        }
        setTimeout(this.updateHint.bind(this), 2000);
    }

    newRound() {
        if(localStorage.getItem("playerRole") === "MI") {
            const cards = document.querySelectorAll(".card.hidden");
            cards.forEach(card => {
                card.addEventListener("click", () => {
                    if(this.#roundActive) {
                        console.log("KAKAKAKAK");
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
                                if (this.#counterTotalBlue === 8) {
                                    this.win(roundScore);
                                    return;
                                }
                            } else if (card.classList.contains("gray")) {
                                this.#roundActive = false;
                                this.#hintActive = true;

                                localStorage.setItem("hintActive", this.#hintActive);
                                localStorage.setItem("roundActive", this.#roundActive);

                                cards.forEach(c => {
                                    c.replaceWith(c.cloneNode(true));
                                });
                                return;
    
                            } else if (card.classList.contains("black")) {
                                this.gameOver(roundScore);
                                return;
                            }
    
                            roundScoreElement.textContent = roundScore;
                                
                            localStorage.setItem("hintActive", this.#hintActive);
                            localStorage.setItem("roundActive", this.#roundActive);
                            localStorage.setItem("counterTotalBlue", this.#counterTotalBlue);
                        }
                    }
                });
            });
        }
    }

    gameOver(score) {
        window.location.href = `game_over.html?score=${score}`;
    }

    win(score) {
        window.location.href = `win.html?score=${score}`;
    }
}
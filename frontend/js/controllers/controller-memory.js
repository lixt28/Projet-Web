import { Memory } from "../models/memory.js";
import { Notifier } from "../patterns/notifier.js";

export class ControllerMemory extends Notifier {
    #memory;

    constructor() {
        super();
        this.#memory = new Memory();
    }

    get memory() { return this.#memory }

    async newGame() {
        await this.#memory.newGame(25);
        this.notify('New Game');
        this.saveGame();
    }

    saveGame() {
        const data = this.#memory.toData();
        localStorage.setItem("memory", JSON.stringify(data));
    }

    loadGame() {
        const data = localStorage.getItem("memory");
        if (data) {
            const parsedData = JSON.parse(data);
            this.#memory.fromData(parsedData);
            this.notify('Load Game');
            return true;
        } else {
            return false;
        }
    }

    start() {
        if (!this.loadGame()) {
            this.newGame();
        }
    }
}
export class Card {
    #word;
    #color;

    constructor(word, color) {
        if (typeof word !== 'string') {
            throw new TypeError('value must be a string');
        }
        if (typeof color !== 'string') {
            throw new TypeError('value must be a string');
        }
        this.#word = word;
        this.#color = color;
    }

    get word() {
        return this.#word;
    }

    get color() {
        return this.#color;
    }
}

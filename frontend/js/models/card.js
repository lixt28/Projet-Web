export class Card {
    #value;
    #color;

    constructor(value, color) {
        if (typeof value !== 'string') {
            throw new TypeError('value must be a string');
        }
        this.#value = value;
        this.#color = color;
    }

    get value() { return this.#value }
    get color() { return this.#color }
}

export default class Activiteit {
  #title;
  #date;
  #info;

  constructor(title, date, info) {
    this.title = title;
    this.info = info;
    this.date = date;
  }

  get title() {
    return this.#title;
  }
  set title(value) {
    this.#title = value;
  }
  get date() {
    return this.#date;
  }
  set date(value) {
    this.#date = new Date(value);
  }
  get info() {
    return this.#info;
  }
  set info(value) {
    this.#info = value;
  }

  toJSON() {
    return {
      title: this.#title,
      date: this.#date,
      info: this.#info,
    };
  }
}

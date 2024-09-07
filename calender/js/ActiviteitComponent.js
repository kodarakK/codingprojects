import Activiteit from "./Activeit.js";

export default class ActiviteitComponent {
  #storage;
  #activiteiten = [];
  #months = [
    "januari",
    "februari",
    "maart",
    "april",
    "mei",
    "juni",
    "juli",
    "augustus",
    "september",
    "oktober",
    "november",
    "december",
  ];

  constructor(storage) {
    this.#storage = storage;
  }

  async initalize() {
    await this.#getActiviteitenFromStorage();

    const addButton = document.getElementById("add");
    const deleteButton = document.getElementById("clear");
    const titleText = document.getElementById("title");
    const infoText = document.getElementById("info");
    const dateText = document.getElementById("date");

    addButton.onclick = () => {
      try {
        this.#addActiviteit(
          titleText.value,
          new Date(dateText.value),
          infoText.value
        );
        titleText.value = "";
        dateText.value = "";
        infoText.value = "";
      } catch (e) {
        alert(e.message);
      }
    };

    deleteButton.onclick = () => {
      if (confirm("click ok to clear all milestones"))
        this.#clearActiviteiten();
    };

    this.#toHtml();
  }

  #addActiviteit(title, date, info) {
    if (!title) throw new Error("Titel vereist.");
    if (!date || !(date instanceof Date) || isNaN(date))
      throw new Error("Datum vereist.");
    if (!info) throw new Error("Info vereist.");
    if (date < new Date()) throw new Error("Datum is in het verleden.");

    this.#activiteiten.push(new Activiteit(title, date, info));
    this.#setActiviteitenInStorage();
    this.#toHtml();
  }

  #toHtml() {
    const overview = document.getElementById("overview");
    overview.innerHTML = "";

    this.#activiteiten.map((a, ind) => {
      const note = document.createElement("div");
      note.setAttribute("class", "notification");

      const btn = document.createElement("button");
      btn.setAttribute("class", "delete");
      btn.addEventListener("click", () => {
        if (confirm("Click OK to confirm the deletion"));
        this.#deleteActiviteit(ind);
      });
      note.appendChild(btn);

      const text = document.createTextNode(
        `${a.title}: ${a.info} | ${a.date} ${
          this.#months[a.date.getMonth()]
        } `
      );
      note.appendChild(text);

      overview.appendChild(note);
    });
  }

  async #getActiviteitenFromStorage() {
    this.#activiteiten = [];
    let activiteitenAlsJson;
    try {
      const response = await fetch("./file/data.json");
      if (!response.ok) throw new Error(`fout: ${response.status}`);
      activiteitenAlsJson = await response.json();
    } catch (error) {
      alert(error.message());
    }

    if (activiteitenAlsJson) {
      this.#activiteiten = activiteitenAlsJson.map(
        (a) => new Activiteit(a.title, a.date, a.info)
      );
      this.#activiteiten = this.#activiteiten.filter(
        (a) => a.date >= new Date()
      );
    }
  }

  #setActiviteitenInStorage() {
    this.#activiteiten.sort((a, b) => a.date - b.date);
    $.post("./save.php", { data: JSON.stringify(this.#activiteiten) });
  }

  #clearActiviteiten() {
    this.#activiteiten = [];
    this.#storage.removeItem("activiteiten");
    this.#toHtml();
  }
  #deleteActiviteit(ind) {
    this.#activiteiten.splice(ind, 1);
    this.#setActiviteitenInStorage();
    this.#toHtml();
  }
}

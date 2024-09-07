import ActiviteitComponent from "./ActiviteitComponent.js";

function init() {
  const actComp = new ActiviteitComponent(this.localStorage);
  actComp.initalize();
}

window.onload = init;

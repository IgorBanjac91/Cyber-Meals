let filterBtn = document.querySelector("#orders-filter");
let filterContainer = document.querySelector(".filter")

filterBtn.addEventListener("click", function toogleFilter() {
  if (filterContainer.style.display == "none") {
    filterContainer.style.display = "block";
  }
  else {
    filterContainer.style.display = "none";
  }
})
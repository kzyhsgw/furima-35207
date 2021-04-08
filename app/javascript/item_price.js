window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const addTaxDom = document.getElementById("add-tax-price");
    addTaxDom.innerHTML = Math.floor(priceInput.value / 10);
    const showProfitDom = document.getElementById("profit");
    showProfitDom.innerHTML = Math.floor(priceInput.value * 9 / 10);
  })
});
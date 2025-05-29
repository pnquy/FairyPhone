document.querySelectorAll('.quantity button').forEach(function (button) {
    button.addEventListener('click', function () {
        var quantityGroup = this.closest('.quantity');
        var parentTd = quantityGroup.parentElement.parentElement;
        var priceElement = parentTd.querySelector('.price');
        var totalElement = parentTd.querySelector('.total');

        var quantity = this.parentElement.parentElement.querySelector('input');

        // Update input quantity
        var oldValue = parseFloat(quantity.value);

        if (this.classList.contains('btn-plus')) {
            var newVal = oldValue + 1;
        } else {
            if (oldValue > 0) {
                var newVal = oldValue - 1;
            } else {
                newVal = 0;
            }
        }

        quantity.value = newVal;

        // Update total price
        var price = parseFloat(priceElement.textContent.replace('$', ''));
        var totalPrice = price * quantity.value;
        totalElement.textContent = "$" + totalPrice.toFixed(3);
    });
});
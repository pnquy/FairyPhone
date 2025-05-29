document.getElementById('submitData').addEventListener('click', function () {
    // Gather data from different sections
    var data = {
        Name: document.getElementById('name').value,
        Brand: document.getElementById('brand').value,
        Ram: parseInt(document.getElementById('ram').value),
        Rom: parseInt(document.getElementById('rom').value),
        Color: document.getElementById('color').value,
        Price: parseFloat(document.getElementById('price').value),
        Discount: parseFloat(document.getElementById('discount').value)
        // Add more properties as needed
    };

    // Send data to the controller using fetch
    fetch('@Url.Action("YourAction", "YourController")', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(data)
    })
        .then(response => response.json())
        .then(data => {
            // Handle success, if needed
        })
        .catch(error => {
            // Handle error, if needed
        });
});
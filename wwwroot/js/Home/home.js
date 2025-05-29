function toggleNavbarMethod() {
    if (window.innerWidth < 992) {
        console.log("I invoked");
        document.querySelectorAll('.navbar .dropdown').forEach(function (dropdown) {
            dropdown.addEventListener('mouseover', function () {
                this.querySelector('.dropdown-toggle').click();
            });
            dropdown.addEventListener('mouseout', function () {
                this.querySelector('.dropdown-toggle').click();
                this.querySelector('.dropdown-toggle').blur();
            });
        });
    } else {
        document.querySelectorAll('.navbar .dropdown').forEach(function (dropdown) {
            dropdown.removeEventListener('mouseover', function () { });
            dropdown.removeEventListener('mouseout', function () { });
        });
    }
}

toggleNavbarMethod();
window.addEventListener('resize', toggleNavbarMethod);
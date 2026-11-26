document.addEventListener("click", e => {
    console.log("clicked")
    const isDropdownButton = e.target.matches("[data-dropdown-menu]");
    if (!isDropdownButton && e.target.closest("[data-dropdown]") != null) return

    let currentDropdown;
    if (isDropdownButton) {
        currentDropdown = e.target.closest("[data-dropdown]");
        currentDropdown.classList.toggle("active");
    }

    document.querySelectorAll("[data-dropdown].active").forEach(dp => {
        if (dp === currentDropdown) return;
        dp.classList.remove("active");
    });
});

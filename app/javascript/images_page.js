function initImagesPage() {
    document.querySelectorAll(".image-card-item--clickable").forEach((card) => {
        card.onclick = (event) => {
            if (event.target.closest("a, button, input, select, textarea, label, form")) {
                return;
            }

            const href = card.dataset.href;

            if (href) {
                window.location.href = href;
            }
        };
    });
}

document.addEventListener("turbo:load", initImagesPage);
document.addEventListener("DOMContentLoaded", initImagesPage);
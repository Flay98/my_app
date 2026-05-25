function initWorkPage() {
    const viewer = document.querySelector(".work-viewer");

    if (!viewer) {
        return;
    }

    let imageCurrentIndex = Number(viewer.dataset.currentIndex || 0);
    const selectedThemeId = Number(viewer.dataset.themeId || 0);
    const themeImagesSize = Number(viewer.dataset.length || 0);

    const prevButton = document.querySelector(".img-left-side");
    const nextButton = document.querySelector(".img-right-side");

    const imageElement = document.querySelector(".current-image");
    const titleElement = document.querySelector(".current-image-title");
    const averageElement = document.querySelector(".current-average");

    const ratingCurrentIndexInput = document.querySelector(".rating-current-index");
    const ratingImageIdInput = document.querySelector(".rating-image-id");
    const ratingInput = document.querySelector(".rating-input");

    if (!prevButton || !nextButton) {
        return;
    }

    function updateImage(data) {

        imageCurrentIndex = Number(data["new_image_index"]);

        imageElement.src = data["image_url"];
        imageElement.alt = data["name"];
        imageElement.dataset.imageId = data["image_id"];

        titleElement.textContent = data["name"];
        averageElement.textContent = data["common_ave_value"];

        ratingCurrentIndexInput.value = imageCurrentIndex;
        ratingImageIdInput.value = data["image_id"];
        ratingInput.value = data["value"] || "";
    }

    function loadImage(direction) {

        if (!selectedThemeId || !themeImagesSize) {
            return;
        }

        fetch(`/api/${direction}_image?index=${imageCurrentIndex}&theme_id=${selectedThemeId}&length=${themeImagesSize}`)
            .then((response) => {
                return response.json();
            })
            .then((data) => updateImage(data))
            .catch((error) => console.error("Image API error:", error));
    }

    prevButton.onclick = () => loadImage("prev");
    nextButton.onclick = () => loadImage("next");
}

document.addEventListener("turbo:load", initWorkPage);
document.addEventListener("DOMContentLoaded", initWorkPage);
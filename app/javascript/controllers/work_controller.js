document.addEventListener('DOMContentLoaded', () => {
    let imageCurrentIndex = 0
    let selectedThemeId = parseInt(new URLSearchParams(window.location.search).get('theme_id')) || 0
    let themeImagesSize = document.querySelectorAll('.img-center img').length

    function listNext() {
        $.ajax({
            type: "get",
            url: "/api/next_image",
            data: { index: imageCurrentIndex, theme_id: selectedThemeId, length: themeImagesSize },
            dataType: 'json'
        }).done(function(data) {
            imageCurrentIndex = data.new_image_index
            let pathImage = "/assets/pictures/" + data.file
            document.querySelector(".img-center img").src = pathImage
            document.querySelector(".img-center img").alt = data.name
        })
    }

    function listPrev() {
        $.ajax({
            type: "get",
            url: "/api/prev_image",
            data: { index: imageCurrentIndex, theme_id: selectedThemeId, length: themeImagesSize },
            dataType: 'json'
        }).done(function(data) {
            imageCurrentIndex = data.new_image_index
            let pathImage = "/assets/pictures/" + data.file
            document.querySelector(".img-center img").src = pathImage
            document.querySelector(".img-center img").alt = data.name
        })
    }

    // Привязка кнопок
    document.querySelector(".img-left-side").addEventListener("click", listPrev)
    document.querySelector(".img-right-side").addEventListener("click", listNext)
})
$(document).on('turbolinks:load', function () {
    $("#micropost_picture").bind("change", function () {
        if (this.files[0].size > 1024 * 1024) {
            alert(I18n.t("microposts_form.max_size_upload"))
        }
    });
})
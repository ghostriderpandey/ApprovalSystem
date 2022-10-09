var ajax = {
    doPostAjax: function (url, data, callback) {
        $.ajax({
            type: 'POST',
            url: url,
            data: data,
            success: function (result) {
                return callback(result);
            }
        });
    },
    doGetAjax: function (url, callback) {
        $.ajax({
            type: 'Get',
            url: url,
            success: function (result) {
                return callback(result);
            }
        });
    },
    AjaxPost: function (url, data, callback) {
        $.ajax({
            type: 'POST',
            url: url,
            data: data,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function (result) {
                return callback(result);
            }
        });
    },
}
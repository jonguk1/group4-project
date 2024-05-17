$(document).ready(function() {
    $.ajax({
        url: "/board/board-category",
        type: "GET",
        dataType: "json",
        success: function(response) {
            console.log(response);

            $.each(response, function(index, value) {
                $("#lendServe").append("<a class='dropdown-item' href='/board?boardCategoryId=1&itemCategoryId=" + value.itemCategoryId + "'>" + value.itemCategoryName + "</a>");
                $("#lendServed").append("<a class='dropdown-item' href='/board?boardCategoryId=2&itemCategoryId=" + value.itemCategoryId + "'>" + value.itemCategoryName + "</a>");
                $("#itemCategoryId").append("<option value='" + value.itemCategoryId + "'>" + value.itemCategoryName + "</option>");
            });
        },
        error: function(xhr, status, error) {
            console.error("요청 실패:", status, error);
        }
    });
});
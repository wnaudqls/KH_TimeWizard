$("input[type=radio]").click(function(){
    $(this).prop("checked", true);
    $("form").submit();
})
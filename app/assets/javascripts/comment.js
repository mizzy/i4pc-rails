function post_comment (media_id, user_id, user_name, icon_url) {
    var comment = $('#post_comment').val();
    $('#post_comment').attr({ disabled: "disabled" });
    $('#submit').attr({ disabled: "disabled" });
    $('#comment_status').html('<img src="/img/loading_2.gif">');

    $.post(
        '/comment/' + media_id,
        { comment_text: comment },
        function (){
            $('#comment_status').html('Completed.');
            $('#post_comment').removeAttr('disabled');
            $('#post_comment').val('');
            $('#submit').removeAttr('disabled');

            var html = '<div class="comment">';
            html += '<div class="comment_icon">';
            html += '<a href="/user/' + user_id + '"><img src="' + icon_url + '" /></a>';
            html += '<div class="delta"></div>';
            html += '</div>';
            html += '<div class="comment_text">';
            html += '<a href="/user/' + user_id + '">' + user_name + '</a> : ' + comment;
            html += '</div>';
            html += '<br class="clear" />';
            html += '</div>';

            $('.comments').append(html);
        }
    );
}

function reply_comment(user_name) {
    var text_area = $('#post_comment');
    var text = text_area.val();
    text_area.val('@' + user_name + ' ' + text);
}
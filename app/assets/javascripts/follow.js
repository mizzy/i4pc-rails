function follow_action(user_id, id) {
    var element;
    if ( !id ) {
        element = $('#follow_status');
    }
    else {
        element = $(id);
    }

    var status = element.attr('class');
    element.html('<img src="/img/loading_2.gif">');
    element.attr('class', 'processing');

    if ( status == 'follow' ) {
        $.get(
            '/follow/' + user_id,
            function (data) {
                var outgoing_status = data['outgoing_status'];
                if ( outgoing_status == 'requested' ) {
                    element.attr('class', 'requested');
                    element.text('Requested');
                }
                else if ( outgoing_status == 'follows' ) {
                    element.attr('class', 'following');
                    element.text('Following');
                }
            },
            'json'
        );
    }
    else if ( status == 'requested' || status == 'following' ) {
        $.get(
            '/unfollow/' + user_id,
            function (data) {
                element.attr('class', 'follow');
                element.text('Follow');
            },
            'json'
        );

    }
}

$.event.add(
    window,
    'load',
    function() {
        $('#follow_area').hover(
            function() {
                var status = $('#follow_status').attr('class');
                if ( status == 'following' || status == 'requested' ) {
                    $('#follow_status').text('Unfollow');
                }
            },
            function() {
                var status = $('#follow_status').attr('class');
                if ( status == 'following' ) {
                    $('#follow_status').text('Following');
                }
                else if ( status == 'requested' ) {
                    $('#follow_status').text('Requested');
                }
            }
        );
    }
)

function get_outgoing_statuses(content, user_id) {
    elements = $(content).children();
    for ( var i = 0; i < elements.length; i++ ) {
        element = $(elements[i]);
        var id = element.attr('id');
        if ( element.attr('class') != 'outgoing_status' || user_id == id ) {
            continue;
        }
        
        get_outgoing_status(id);
    }
}

function get_outgoing_status(id, username) {
    $.get(
        '/relationship/' + id,
        function(data) {
            var element = $('#' + id);
            var status = data['outgoing_status'];
            var klass;
            if ( status == 'none' ) {
                status = 'Follow';
                klass  = 'follow';
            }
            else if ( status == 'follows' ) {
                status = 'Following';
                klass  = 'following';
            }
            else if ( status == 'requested' ) {
                status = 'Requested';
                klass  = 'requested';
            }
            var a = $('<a>');
            a.attr('class', klass);
            a.attr('id', 'follow_status_' + id);
            a.attr('href', 'javascript:follow_action(' + id + ', "#follow_status_' + id + '")');
            a.text(status);
            a.hover(
                function() {
                    var status = a.attr('class');
                    if ( status == 'following' || status == 'requested' ) {
                        a.text('Unfollow');
                    }
                },
                function() {
                    var status = a.attr('class');
                    if ( status == 'following' ) {
                        a.text('Following');
                    }
                    else if ( status == 'requested' ) {
                        a.text('Requested');
                    }
                }
            );

            element.html(a);
        },
        'json'
    );
}
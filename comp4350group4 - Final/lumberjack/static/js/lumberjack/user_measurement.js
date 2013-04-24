function save_measurement(current_user, user_avatar, testing)
{
    url = "/user/" + current_user + "/new_measurement";
    if(!_.isUndefined(testing) || $('#measurement_form').valid()){
        var form_json = form_to_json($("#measurement_form"));
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: url,
            data: JSON.stringify(form_json),
            success: function(data){
                if(_.has(data, 'error')){
                    $('#modal-confirm').modal('show'); 
                    $('#feedback').addClass('hide');
                }
                else{
                    $('#feedback').removeClass('hide');
                    $('#feedback #feedback_text').text('Successfully added a new measurement');
                    $('#feedback #feedback_text').css('color', 'green');
                    var avatar = user_avatar
                    addItemToFeed(current_user, avatar, "Has added a new measurement " +
                                  data['type'] + ": " + data['value'] + " " +
                                  data['unit']);
                    $('#add_user_measurement').modal('hide');   
                }
            },
            dataType: 'json'
        });
    }
    return 0;
}

function form_to_json(form)
{
    var json_form = {};
    var text_inputs = form.find('input:text');
    _.each(text_inputs, function(i){
        var input = $(i);
        json_form[input.attr('name')] = input.val();
    });
    return json_form
}

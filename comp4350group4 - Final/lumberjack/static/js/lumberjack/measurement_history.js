function getMeasurementHistory(target_user, measurement){
    url = "/user/" + target_user + "/measurement/" + measurement;
    $.ajax({
        type: "GET",
        contentType: "application/json; charset=utf-8",
        url: url,
        success: function(data){
            displaySummaryTable(data);
        },
        error: function(){
            console.log("error");
        },
        dataType: 'json'
    });

    return 0;
}

function displaySummaryTable(data){
    //format the data for datatables plugin
    var formattedData = _.map(data['measurements'], function(measurement){
        var readableDate = moment(measurement['date']).format('MMMM Do YYYY, h:mm a');
        return [measurement['type'], measurement['value'] + " " + measurement['unit'], readableDate];
    });
    var history_table = $('#history_table');
    if(!_.isUndefined(history_table['dataTable']))
    {
        history_table.dataTable( {
            "aaData": formattedData,
            "aoColumns": [
                { "sTitle": "Measurement" },
                { "sTitle": "Value" },
                { "sTitle": "Measured on" }
            ],
        } );
    }
return 0;
}



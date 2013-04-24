//jTable instance
function createWorkoutTableContainer()
{
    $('#WorkoutTableContainer').jtable(
    {
        title: 'Table of workouts',
        selecting: true,
        actions: 
        {
            listAction: '/workouts/getWorkouts',
        },
        fields: 
        {
            id: 
            {
                key: true,
                list: false
            },
            name: 
            {
                title: 'Workout Name',
                width: '40%'
            },
            description: 
            {
                title: 'Description',
                width: '40%'
            },
            level: 
            {
                title: 'Difficulty',
                width: '10%'
            },
            userid: 
            {
                title: 'Author',
                width: '10%'
            }
        },
        selectionChanged: function () 
        {
            var $selectedRows = $('#WorkoutTableContainer').jtable('selectedRows');
            $selectedRows.each(function () 
            {
                var record = $(this).data('record');
                var name = record.name;
                document.location.href = '/workouts/workout?name='+name;
            });
        }
    });
    return 0;
}
function setUpExerciseSearchBar()
{
    $.ajax(
    {
        contentType: "application/json",
        url: "/workouts/getExerciseTypes",
        success: function(jsonResponse)
        {
            var names = jsonResponse.names.split(",");
            for(var i = 0; i < names.length; i++)
            {
                if(names[i].length > 0)
                {
                    $("#ExerciseSearchBar").append('<option value="' + names[i] + '">' + names[i] + '</option>');
                }
            }
        },
    });

    $('#ExerciseSearchBar').change(function (e) 
    {
        e.preventDefault();
        $('#WorkoutTableContainer').jtable('load', { exercise: $('#ExerciseSearchBar').val(), });
    });
    return 0;
}
function setUpWorkoutSearchBar()
{
    $(function() 
    {
        function log( message ) 
        {
            $( "<div>" ).text( message ).prependTo( "#log" );
            $( "#log" ).scrollTop( 0 );
        }
        $( "#WorkoutSearchBar" ).autocomplete(
        {
            source: function( request, response )
            {
                $.ajax(
                {
                    url: "/workouts/autocompleteWorkouts",
                    dataType: "json",
                    data: 
                    {
                        featureClass: "P",
                        style: "full",
                        maxRows: 3,
                        name_startsWith: request.term
                    },
                    success: function( data )
                    {
                        response( $.map( data.workouts, function( item )
                        {
                            return { label: item.name , value: item.name }
                        }));
                    },
                    error : function(o, e_status, e_text)
                    {
                        console.log(e_status);
                        console.log(e_text);
                    }

                });
            },
            minLength: 1,
            select: function( event, ui )
            {
                log( ui.item ?  "Selected: " + ui.item.label : "Nothing selected, input was " + this.value); document.location.href = '/workouts/workout?name='+ui.item.label;
            },
            open: function()
            {
                $( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
            },
            close: function()
            {
                $( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
            }
        });
    });
    //events
    $('#WorkoutSearchBar').dblclick(function (e) 
    {
        if ($('#WorkoutSearchBar').val() != null && $('#WorkoutSearchBar').val() != "")
        {
            e.preventDefault();
            $('#WorkoutTableContainer').jtable('load', { workout: $('#WorkoutSearchBar').val(), });
        }
    });
    $('#WorkoutSearchBar').keyup(function(e)
    {
        if(e.keyCode == 13)
        {
            $("#WorkoutSearchBar").dblclick();//hack to make selenium work (SELENIUM DOES NOT REGISTER ENTER KEY)
        }
    });
    return 0;
}

function setUpDescriptionSearchBar()
{
    $('#DescriptionSearchBar').dblclick(function (e) 
    {
        if ($('#DescriptionSearchBar').val() != null && $('#DescriptionSearchBar').val() != "")
        {
            e.preventDefault();
            $('#WorkoutTableContainer').jtable('load', { description: $('#DescriptionSearchBar').val(), });
        }
    });
    $('#DescriptionSearchBar').keyup(function(e)
    {
        if(e.keyCode == 13)
        {
            $("#DescriptionSearchBar").dblclick();
        }
    });
    return 0;
}
function setUpAuthorSearchBar()
{
    $('#AuthorSearchBar').dblclick(function (e) 
    {
        if ($('#AuthorSearchBar').val() != null && $('#AuthorSearchBar').val() != "")
        {
            e.preventDefault();
            $('#WorkoutTableContainer').jtable('load', { author: $('#AuthorSearchBar').val(), });
        }
    });
    $('#AuthorSearchBar').keyup(function(e)
    {
        if(e.keyCode == 13)
        {
            $("#AuthorSearchBar").dblclick();
        }
    });
    return 0;
}

$(document).ready(function() 
{
    createWorkoutTableContainer();
    setUpExerciseSearchBar();
    setUpWorkoutSearchBar();
    setUpDescriptionSearchBar();
    setUpAuthorSearchBar();
});

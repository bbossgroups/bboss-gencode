var UIConfirmations = function () {

    var handleSample = function () {
    	$('[data-toggle=confirmation]').confirmation();

        $('[action=delete]').on('confirmed.bs.confirmation', function (event) {
        	var id = $(event.currentTarget).attr("dataid");
        	TableAdvanced.deletegencode(id,event)
        });

           

        
    }


    return {
        //main function to initiate the module
        init: function () {

           handleSample();

        }

    };

}();
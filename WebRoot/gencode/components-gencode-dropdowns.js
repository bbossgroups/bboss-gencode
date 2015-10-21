var ComponentsDropdowns = function () {

     
    

    return {
    
    	loadtables:function(event,targetE)
    	{
    		 Metronic.startPageLoading({message:"装载中..."});
    		var dbname = $(event.currentTarget).val();
    		$.ajax({
                type: "POST",
                cache: false,
                url: "loadtables.page",
                data:{dbname:dbname},
                dataType: "json",
                success: function (tables) {
                	 Metronic.stopPageLoading();
                	 var hcontent = "";
                	 var t = '';
                	 for(var table in tables)
                	{
                		 hcontent = hcontent+"<option value='"+tables[table]+"'>"+tables[table]+"</option>";
                		 if(t == '')
                			 t = tables[table];
                	}
                	var e = $("#"+targetE); 
                    e.html(hcontent);
                    e.select2({
                        placeholder: "Select",
                        allowClear: true
                    });
                   
                    
                },
                error: function (xhr, ajaxOptions, thrownError) {
                	 alert(thrownError);
                	Metronic.stopPageLoading();
                },
                async: false
            });
    	},
    	loadtablesofdbname:function(dbname)
    	{
    		 
    		 Metronic.startPageLoading();
    		$.ajax({
                type: "POST",
                cache: false,
                url: "loadtables.page",
                data:{dbname:dbname},
                dataType: "json",
                success: function (tables) {
                	 
                	 var hcontent = "";
                	 for(var table in tables)
                	{
                		 hcontent = hcontent+"<option value='"+tables[table]+"'>"+tables[table]+"</option>";
                	}
                    $("#tableName").html(hcontent);
                    $("#tableName").select2({
                        placeholder: "Select",
                        allowClear: true
                    });
                    Metronic.stopPageLoading();
                },
                error: function (xhr, ajaxOptions, thrownError) {
                	 alert(thrownError);
                	 
                },
                async: false
            });
    	},
	    loadds:function(event,targetE)
		{
			 Metronic.startPageLoading();
			
			$.ajax({
	            type: "POST",
	            cache: false,
	            url: "loadds.page",
	            data:{},
	            dataType: "json",
	            success: function (dses) {
	            	 Metronic.stopPageLoading();
	            	 var hcontent = "";
	            	 var dbname = "";
	            	 for(var ds in dses)
	            	{
	            		 if(dbname == '')
	            			 dbname = dses[ds].dbname;
	            		 hcontent = hcontent+"<option value='"+dses[ds].dbname+"'>"+dses[ds].dbname+"</option>";
	            		 
	            	}
	            	 
	                $("#"+targetE).html(hcontent);
	                $("#"+targetE).select2({
                        placeholder: "Select",
                        allowClear: true
                    });
                   
	                ComponentsDropdowns.loadtablesofdbname(dbname)
	                
	            },
	            error: function (xhr, ajaxOptions, thrownError) {
	            	 alert(thrownError);
	            	Metronic.stopPageLoading();
	            },
	            async: false
	        });
			
			
		}
        
    };

}();
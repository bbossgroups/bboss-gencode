var TableAdvanced = function () {


    var initTable5 = function () {

        var table = $('#sample_5');

      
        var oTable = table.dataTable({
            "dom": "<'row'<'col-md-6 col-sm-12'l><'col-md-6 col-sm-12'f>r>t<'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>", // datatable layout without  horizobtal scroll
            "scrollY": "300",
            "deferRender": true,
            "order": [
                [1, 'asc']
            ],
            "columns": [{
                "orderable": false
            }, {
                "orderable": true
            }, {
                "orderable": true
            }, {
                "orderable": true
            }, {
                "orderable": true
            }, {
                "orderable": true
            }, {
                "orderable": true
            }, {
                "orderable": true
            }, {
                "orderable": false
            }],
            "lengthMenu": [
                [5, 15, 20, -1],
                [5, 15, 20, "All"] // change per page values here
            ],
            "pageLength": 10 // set the initial value            
        });

        $('#group-checkable').change(function () {
            var set = jQuery(this).attr("data-set");
            var checked = jQuery(this).is(":checked");
            jQuery(set).each(function () {
                if (checked) {
                    $(this).attr("checked", true);
                    $(this).parents('tr').addClass("active");
                } else {
                    $(this).attr("checked", false);
                    $(this).parents('tr').removeClass("active");
                }
            });
            jQuery.uniform.update(set);
        });

        table.on('change', 'tbody tr .checkboxes', function () {
            $(this).parents('tr').toggleClass("active");
        });
        var tableWrapper = $('#sample_5_wrapper'); // datatable creates the table wrapper by adding with id {your_table_jd}_wrapper
        var tableColumnToggler = $('#sample_5_column_toggler');
        //tableWrapper.find('.dataTables_length select').select2(); // initialize select2 dropdown
        
        tableWrapper.find('.dataTables_length select').addClass("form-control input-xsmall input-inline"); // modify table per page dropdown
       

        /* handle show/hide columns*/
        $('input[type="checkbox"]', tableColumnToggler).change(function () {
            /* Get the DataTables object again - this is not a recreation, just a get of the object */
            var iCol = parseInt($(this).attr("data-column"));
            var bVis = oTable.fnSettings().aoColumns[iCol].bVisible;
            oTable.fnSetColumnVis(iCol, (bVis ? false : true));
        });
        
        

        

        
    };
    var handleTable = function () {

        function restoreRow(oTable, nRow) {
            var aData = oTable.fnGetData(nRow);
            var jqTds = $('>td', nRow);

            for (var i = 0, iLen = jqTds.length; i < iLen; i++) {
                oTable.fnUpdate(aData[i], nRow, i, false);
            }

            oTable.fnDraw();
        }

        function editRow(oTable, nRow) {
            var aData = oTable.fnGetData(nRow);
            var jqTds = $('>td', nRow);
            jqTds[0].innerHTML = '<input type="text" id="dsdbname" name="dsdbname" class="form-control input-small" value="' + aData[0] + '">';
            jqTds[1].innerHTML = '<input type="text" id="dsdburl" name="dsdburl" class="form-control input-small" value="' + aData[1] + '">';
            jqTds[2].innerHTML = '<input type="text" id="dsdbdriver" name="dsdbdriver" class="form-control input-small" value="' + aData[2] + '">';
            jqTds[3].innerHTML = '<input type="text" id="dsdbuser" name="dsdbuser" class="form-control input-small" value="' + aData[3] + '">';
            jqTds[4].innerHTML = '<input type="text" id="dsdbpassword" name="dsdbpassword" class="form-control input-small" value="' + aData[4] + '">';
            jqTds[5].innerHTML = '<input type="text" id="dsvalidationQuery" name="dsvalidationQuery" class="form-control input-small" value="' + aData[5] + '">';
            jqTds[6].innerHTML = '<input type="text" id="dsdbdesc"  name="dsdbdesc"  class="form-control input-small" value="' + aData[6] + '">';
            jqTds[7].innerHTML = '<a class="edit" href="">Save</a>';
            jqTds[8].innerHTML = '<a class="cancel" href="">Cancel</a>';
            FormValidation.initdsform();
        }

       
        function saveRow(oTable, nRow) {
        	var dsform  = $("#dsform");
        	  var validrs = dsform.valid() ;
              
              if(!validrs)
              	return false;
              else
              {
            	  
            	  
            	  var error1 = $('.alert-danger', dsform);
            	  error1.hide();
              }  
            var jqInputs = $('input', nRow);
            var dbname = jqInputs[0].value;
            var dburl = jqInputs[1].value;
            var dbdriver = jqInputs[2].value;
            var dbuser = jqInputs[3].value;            
            var dbpassword = jqInputs[4].value;
            var validationQuery = jqInputs[5].value;
            var dbdesc = jqInputs[6].value;
          
            $.ajax({
     		   type: "POST",
     			url : "addDatasource.page",
     			data :{dbname:dbname,dburl:dburl,dbuser:dbuser,dbpassword:dbpassword,dbdesc:dbdesc,dbdriver:dbdriver,validationQuery:validationQuery},
     			dataType : 'json',
     			async:false,
     			beforeSend: function(XMLHttpRequest){
     				Metronic.startPageLoading();			 	
     				},
     			
     				error : function(xhr, ajaxOptions, thrownError) {
        				Metronic.stopPageLoading();
        			},

        			success : function(responseText, statusText, xhr, $form) {
        				Metronic.stopPageLoading();

        				var msg = responseText;
        				 
        				var title = '数据源保存';
        				if (msg == 'success') {
        					title = '数据源保存成功！';
        					 
        				} else
        					title = responseText;

        				toastr.options = {
        					"closeButton" : true,
        					"debug" : false,
        					"positionClass" : "toast-top-center",
        					"onclick" : null,
        					"showDuration" : "0",
        					"hideDuration" : "0",
        					"timeOut" : "10000",
        					"extendedTimeOut" : "0",
        					"showEasing" : "swing",
        					"hideEasing" : "linear",
        					"showMethod" : "fadeIn",
        					"hideMethod" : "fadeOut"
        				};

        				toastr['success'](title, ""); // Wire up an event handler to a button in the toast, if it exists
        				ComponentsDropdowns.loadds(event,"dbname");
        			}
     				
     		  });
        	 
           
            oTable.fnUpdate(jqInputs[0].value, nRow, 0, false);
            oTable.fnUpdate(jqInputs[1].value, nRow, 1, false);
            oTable.fnUpdate(jqInputs[2].value, nRow, 2, false);
            oTable.fnUpdate(jqInputs[3].value, nRow, 3, false);
            oTable.fnUpdate(jqInputs[4].value, nRow, 4, false);
            oTable.fnUpdate(jqInputs[5].value, nRow, 5, false);
            oTable.fnUpdate(jqInputs[6].value, nRow, 6, false);
            oTable.fnUpdate('<a class="edit" href="">Edit</a>', nRow, 7, false);
            oTable.fnUpdate('<a class="delete" href="">Delete</a>', nRow, 8, false);
            oTable.fnDraw();
        }

        function cancelEditRow(oTable, nRow) {
            var jqInputs = $('input', nRow);
            oTable.fnUpdate(jqInputs[0].value, nRow, 0, false);
            oTable.fnUpdate(jqInputs[1].value, nRow, 1, false);
            oTable.fnUpdate(jqInputs[2].value, nRow, 2, false);
            oTable.fnUpdate(jqInputs[3].value, nRow, 3, false);
            oTable.fnUpdate(jqInputs[4].value, nRow, 4, false);
            oTable.fnUpdate(jqInputs[5].value, nRow, 5, false);
            oTable.fnUpdate(jqInputs[6].value, nRow, 6, false);
            oTable.fnUpdate('<a class="edit" href="">Edit</a>', nRow, 7, false);
            oTable.fnDraw();
        }

        var table = $('#ds_editable');

        var oTable = table.dataTable({

            // Uncomment below line("dom" parameter) to fix the dropdown overflow issue in the datatable cells. The default datatable layout
            // setup uses scrollable div(table-scrollable) with overflow:auto to enable vertical scroll(see: assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js). 
            // So when dropdowns used the scrollable div should be removed. 
            //"dom": "<'row'<'col-md-6 col-sm-12'l><'col-md-6 col-sm-12'f>r>t<'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>",

            "lengthMenu": [
                [5, 15, 20, -1],
                [5, 15, 20, "All"] // change per page values here
            ],

            // Or you can use remote translation file
            //"language": {
            //   url: '//cdn.datatables.net/plug-ins/3cfcc339e89/i18n/Portuguese.json'
            //},

            // set the initial value
            "pageLength": 10,

            "language": {
                "lengthMenu": " _MENU_ records"
            },
            "columnDefs": [{ // set default column settings
                'orderable': false,
                'targets': [0,1,2,3,4,5,6,7,8]
            }, {
                "searchable": false,
                "targets": [0]
            }],
            "order": [            ] // set first column as a default sort by asc
        });

        var tableWrapper = $("#ds_editable_wrapper");

        tableWrapper.find(".dataTables_length select").select2({
            showSearchInput: false //hide search box with special css class
        }); // initialize select2 dropdown

        var nEditing = null;
        var nNew = false;

        $('#ds_editable_new').click(function (e) {
            e.preventDefault();

            if (nNew && nEditing) {
                if (confirm("Previose row not saved. Do you want to save it ?")) {
                	 
                    saveRow(oTable, nEditing); // save
                    $(nEditing).find("td:first").html("Untitled");
                    nEditing = null;
                    nNew = false;

                } else {
                    oTable.fnDeleteRow(nEditing); // cancel
                    nEditing = null;
                    nNew = false;
                    
                    return;
                }
            }

            var aiNew = oTable.fnAddData(['test','jdbc:oracle:thin:@//10.0.14.213:1521/orcl', 'oracle.jdbc.driver.OracleDriver', 'testpdp', 'testpdp', 'SELECT 1 from dual', '测试数据源', '', '']);
            var nRow = oTable.fnGetNodes(aiNew[0]);
            editRow(oTable, nRow);
            nEditing = nRow;
            nNew = true;
        });

        table.on('click', '.delete', function (e) {
            e.preventDefault();

            if (confirm("Are you sure to delete this row ?") == false) {
                return;
            }

            var nRow = $(this).parents('tr')[0];
            var jqInputs = $('td', nRow);
             var dbname = jqInputs[0].innerText;
            oTable.fnDeleteRow(nRow);
            $.ajax({
      		   type: "POST",
      			url : "deleteDatasource.page",
      			data :{"dbname":dbname },
      			dataType : 'json',
      			async:false,
      			beforeSend: function(XMLHttpRequest){
      				Metronic.startPageLoading();			 	
      				},
      			
      				error : function(xhr, ajaxOptions, thrownError) {
         				Metronic.stopPageLoading();
         			},

         			success : function(responseText, statusText, xhr, $form) {
         				Metronic.stopPageLoading();

         				var msg = responseText;
         				 
         				var title = '删除数据源';
         				if (msg == 'success') {
         					title = '删除数据源成功！';
         					 
         				} else
         					title = responseText;

         				toastr.options = {
         					"closeButton" : true,
         					"debug" : false,
         					"positionClass" : "toast-top-center",
         					"onclick" : null,
         					"showDuration" : "0",
         					"hideDuration" : "0",
         					"timeOut" : "10000",
         					"extendedTimeOut" : "0",
         					"showEasing" : "swing",
         					"hideEasing" : "linear",
         					"showMethod" : "fadeIn",
         					"hideMethod" : "fadeOut"
         				};

         				toastr['success'](title, ""); // Wire up an event handler to a button in the toast, if it exists
         				ComponentsDropdowns.loadds(event,"dbname");
         			}
      				
      		  });
            
        });

        table.on('click', '.cancel', function (e) {
            e.preventDefault();
            if (nNew) {
                oTable.fnDeleteRow(nEditing);
                nEditing = null;
                nNew = false;
            } else {
                restoreRow(oTable, nEditing);
                nEditing = null;
            }
        });

        table.on('click', '.edit', function (e) {
            e.preventDefault();

            /* Get the row as a parent of the link that was clicked on */
            var nRow = $(this).parents('tr')[0];

            if (nEditing !== null && nEditing != nRow) {
                /* Currently editing - but not this row - restore the old before continuing to edit mode */
            	
                restoreRow(oTable, nEditing);
                editRow(oTable, nRow);
                nEditing = nRow;
            } else if (nEditing == nRow && this.innerHTML == "Save") {
                /* Editing this row and want to save it */
            	 
                saveRow(oTable, nEditing);
                nEditing = null;
              
            } else {
                /* No edit in progress - let's start one */
                editRow(oTable, nRow);
                nEditing = nRow;
            }
        });
    }
    var initDSTable = function () {

        var table = $('#ds_6');

      
        var oTable = table.dataTable({
            "dom": "<'row'<'col-md-6 col-sm-12'l><'col-md-6 col-sm-12'f>r>t<'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>", // datatable layout without  horizobtal scroll
            "scrollY": "300",
            "deferRender": true,
            "order": [
                [1, 'asc']
            ],
            "columns": [{
                "orderable": false
            }, {
                "orderable": true
            }, {
                "orderable": true
            }, {
                "orderable": true
            }, {
                "orderable": true
            }, {
                "orderable": true
            },  {
                "orderable": false
            }],
            "lengthMenu": [
                [5, 15, 20, -1],
                [5, 15, 20, "All"] // change per page values here
            ],
            "pageLength": 10 // set the initial value            
        });

        $('#ds-group-checkable').change(function () {
            var set = jQuery(this).attr("data-set");
            var checked = jQuery(this).is(":checked");
            jQuery(set).each(function () {
                if (checked) {
                    $(this).attr("checked", true);
                    $(this).parents('tr').addClass("active");
                } else {
                    $(this).attr("checked", false);
                    $(this).parents('tr').removeClass("active");
                }
            });
            jQuery.uniform.update(set);
        });

        table.on('change', 'tbody tr .checkboxes', function () {
            $(this).parents('tr').toggleClass("active");
        });
        var tableWrapper = $('#ds_6_wrapper'); // datatable creates the table wrapper by adding with id {your_table_jd}_wrapper
        var tableColumnToggler = $('#ds_6_column_toggler');
        //tableWrapper.find('.dataTables_length select').select2(); // initialize select2 dropdown
        
        tableWrapper.find('.dataTables_length select').addClass("form-control input-xsmall input-inline"); // modify table per page dropdown
       

        /* handle show/hide columns*/
        $('input[type="checkbox"]', tableColumnToggler).change(function () {
            /* Get the DataTables object again - this is not a recreation, just a get of the object */
            var iCol = parseInt($(this).attr("data-column"));
            var bVis = oTable.fnSettings().aoColumns[iCol].bVisible;
            oTable.fnSetColumnVis(iCol, (bVis ? false : true));
        });
        
        

        

        
    };

     
    return {

        //main function to initiate the module
        init: function () {

            if (!jQuery().dataTable) {
                return;
            }

            //console.log('me 1');

            
            initTable5();
            //initDSTable();
            handleTable();

            //console.log('me 2');
        },
    	regencode:function (gencodeid,url,e) {
            e.preventDefault();
            Metronic.scrollTop();

            
            var formid = $(this).attr("formid");
            var pageContentBody = $('.page-content .page-content-body');

            Metronic.startPageLoading();

            if (Metronic.getViewPort().width < Layout.getResBreakpointMd() && $('.page-sidebar').hasClass("in")) { // close the menu on mobile view while laoding a page 
                $('.page-header .responsive-toggler').click();
            }
            
            $.ajax({
                type: "POST",
                cache: false,
                url: url,	
                data:{gencodeid:gencodeid},
                dataType: "html",
                success: function (res) {
                    Metronic.stopPageLoading();
                    pageContentBody.html(res);
                    Layout.fixContentHeight(); // fix content height
                    Metronic.initAjax(); // initialize core stuff
                   
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    pageContentBody.html('<h4>Could not load the requested content.</h4>');
                    Metronic.stopPageLoading();
                }
            });
            
        }

    };

}();
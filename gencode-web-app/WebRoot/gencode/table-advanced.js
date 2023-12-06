var TableAdvanced = function () {

	var initfieldtablelist = function()
	
	{
		String.prototype.startWith=function(str){  
            if(str==null||str==""||this.length==0||str.length>this.length)  
              return false;  
            if(this.substr(0,str.length)==str)  
              return true;  
            else  
              return false;  
            return true;  
        }  
        String.prototype.endWith=function(str){  
            if(str==null||str==""||this.length==0||str.length>this.length)  
              return false;  
            if(this.substring(this.length-str.length)==str)  
              return true;  
            else  
              return false;  
            return true;  
        } 
		var table = $('#fieldlist');
		// var oTable = table.DataTable({paging: false,searching: false,
			//    ordering:  false});
		 
		 /* Add event listener for opening and closing details
	         * Note that the indicator for showing which row is open is not controlled by DataTables,
	         * rather it is done here
	         */
	        table.on('click', ' tbody td .row-details', function () {
	        	var id = $(this).attr("id");
	        	var detail = $("#detail_"+id)
	            
	            if (detail.css("display")!='none') {
	                /* This row is already open - close it */
	                $(this).addClass("row-details-close").removeClass("row-details-open");
	                detail.hide();
	            } else {
	                /* Open this row */
	                $(this).addClass("row-details-open").removeClass("row-details-close");
	                detail.show();
	            }
	        	
	        	
	        });
	        tableSort();
	        
	        
	}
	var  deletegencode = function(genid,event)
	{
		$.ajax({
  		   type: "POST",
  			url : "deletegencode.page",
  			data :{genid:genid},
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
     				 
     				var title = '记录删除';
     				if (msg == 'success') {
     					title = '记录删除成功！';
     					ComponentsDropdowns.loadds(event,"dbname");
     					$('#reloadbuttom').click();
     				}
     				else if (msg == 'norecord') {
     					title = '要删除的记录不存在！';
     					 
     				} 
     					
     				else
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
     				
     			}
  				
  		  });
	};
    var initgencodelist = function () {

        var table = $('#gencodelist');

    
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
            
            "pageLength": 5 // set the initial value            
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
        var tableWrapper = $('#gencodelist_wrapper'); // datatable creates the table wrapper by adding with id {your_table_jd}_wrapper
        var tableColumnToggler = $('#gencodelist_column_toggler');
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
    var  tableSort = function (event) 
    { 
        var tbody = $('#fieldlist > tbody'); 
        var rows = tbody.children(); 
        var selectedRow; 
        var selectDetailRow;
         
        //压下鼠标时选取行 
        rows.mousedown(function(event){
        	 
            var t = event.srcElement ? event.srcElement : event.target;
            var n  = t.tagName;
            var id = t.id;
            if(id && id.startWith("row_"))
            	return true;
            if(n == 'INPUT' || n == 'SELECT' ||n == 'CHECKBOX' || n == 'RADIO' || n == 'TEXTAREA')
            	return true;
            
            var sr = this;
        	var rowid = sr.id;
        	if(rowid != null && rowid.startWith("detail_row_"))
        	{
        		selectDetailRow = this;
        		selectedRow = $(selectDetailRow).prev()[0];
        	}
        	else
    		{
        		selectedRow = this;
        		selectDetailRow = $(selectedRow).next()[0];
    		}
            
            tbody.css('cursor', 'move'); 
            return false;    //防止拖动时选取文本内容，必须和 mousemove 一起使用 
        }); 
        rows.mousemove(function(event){ 
        	 var t = event.srcElement ? event.srcElement : event.target;
             var n  = t.tagName;
             var id = t.id;
             if(id && id.startWith("row_"))
             	return true;
             if(n == 'INPUT' || n == 'SELECT' ||n == 'CHECKBOX' || n == 'RADIO' || n == 'TEXTAREA')
             	return true;
            return false;    //防止拖动时选取文本内容，必须和 mousedown 一起使用 
        }); 
        //释放鼠标键时进行插入 
        rows.mouseup(function(){         
        	 var sr = this;
         	var rowid = sr.id;
         	var insertrow;
         	
         	var insertdetailrow;
         	if(rowid != null && rowid.startWith("detail_row_"))
         	{
         		insertdetailrow = this;
         		insertrow = $(this).prev()[0];
         	}
         	else
     		{
         		insertrow = this;
         		insertdetailrow = $(this).next()[0];
     		}
            if(selectedRow) 
            { 
                if(selectedRow != this && selectDetailRow != this && insertdetailrow != selectDetailRow) 
                {
                	if(selectDetailRow.rowIndex == insertrow.rowIndex -1)
                		
                	{	
                		$(insertdetailrow).after($(selectDetailRow)); //插入
                		$(insertdetailrow).after($(selectedRow)); //插入                 
	                    
                	}
                	else
            		{
                		$(insertrow).before($(selectedRow)); //插入                    
	                    $(insertrow).before($(selectDetailRow)); //插入
	                    
            		}
                } 
                tbody.css('cursor', 'default'); 
                selectedRow = null;   
                selectDetailRow = null;
            }                                 
        }); 
        //标示当前鼠标所在位置 
        rows.hover( 
            function(){                     
                if(selectedRow && selectedRow != this) 
                { 
                    //区分大小写的，写成 'mouseover' 就不行                         
                }                     
            }, 
            function(){ 
                if(selectedRow && selectedRow != this) 
                { 
                    
                } 
            } 
        ); 

        //当用户压着鼠标键移出 tbody 时，清除 cursor 的拖动形状，以前当前选取的 selectedRow            
        tbody.mouseover(function(event){ 
            event.stopPropagation(); //禁止 tbody 的事件传播到外层的 div 中 
        });     
        $('#fieldlist').mouseover(function(event){ 
            if($(event.relatedTarget).parents('#content')) //event.relatedTarget: 获取该事件发生前鼠标所在位置处的元素 
            { 
                tbody.css('cursor', 'default'); 
                selectedRow = null; 
                selectDetailRow = null;
            } 
        }); 
    } ;
    var handleTable = function () {

        function restoreRow(oTable, nRow) {
            var aData = oTable.fnGetData(nRow);
            var jqTds = $('>td', nRow);

            for (var i = 0, iLen = jqTds.length; i < iLen; i++) {
                oTable.fnUpdate(aData[i], nRow, i, false);
            }

            oTable.fnDraw();
            initdeleteConfirm(oTable);
            initStopConfirm(oTable);
            initStartConfirm(oTable);
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
            jqTds[7].innerHTML = aData[7];
            jqTds[8].innerHTML = '<a class="edit" href="">保存</a>' 
                + '<a class="cancel" href="">取消</a>';
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
            var aData = oTable.fnGetData(nRow);
            var status = aData[7];
          
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
           
            oTable.fnUpdate(status, nRow, 7, false);
            let opHtml = `<a class="edit" href="javascript:;">
										编辑 </a>
									
									 
										<a class="delete" href="javascript:;"  data-toggle="confirmation" data-original-title="确定要删除吗 ?"  data-placement="left"   data-singleton="true"
					data-btn-ok-label="确定" data-btn-ok-icon="icon-like" data-btn-ok-class="btn-xs btn-success" data-btn-cancel-label="取消" data-btn-cancel-icon="icon-close" data-btn-cancel-class="btn-xs btn-danger"
										dsaction="delete">
										删除 </a>
								 
                                        <a class="start" href="javascript:;"  data-toggle="confirmation" data-original-title="确定要启动数据源吗 ?"  data-placement="left"   data-singleton="true"
                                           data-btn-ok-label="确定" data-btn-ok-icon="icon-like" data-btn-ok-class="btn-xs btn-success" data-btn-cancel-label="取消" data-btn-cancel-icon="icon-close" data-btn-cancel-class="btn-xs btn-danger"
                                           dsaction="start">
                                            启动 </a>

                                        <a class="stop" href="javascript:;"  data-toggle="confirmation" data-original-title="确定要停止数据源吗 ?"  data-placement="left"   data-singleton="true"
                                           data-btn-ok-label="确定" data-btn-ok-icon="icon-like" data-btn-ok-class="btn-xs btn-success" data-btn-cancel-label="取消" data-btn-cancel-icon="icon-close" data-btn-cancel-class="btn-xs btn-danger"
                                           dsaction="stop">
                                            停止 </a>`;
            
            oTable.fnUpdate(opHtml, nRow, 8, false);
            oTable.fnDraw();
            initdeleteConfirm(oTable);
            initStopConfirm(oTable);
            initStartConfirm(oTable);
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
            // oTable.fnUpdate('<a class="edit" href="">Edit</a>', nRow, 7, false);
            var aData = oTable.fnGetData(nRow);
            var status = aData[7];
            oTable.fnUpdate(status, nRow, 7, false); 
            let opHtml = `<a class="edit" href="javascript:;">
										编辑 </a>
									
									 
										<a class="delete" href="javascript:;"  data-toggle="confirmation" data-original-title="确定要删除吗 ?"  data-placement="left"   data-singleton="true"
					data-btn-ok-label="确定" data-btn-ok-icon="icon-like" data-btn-ok-class="btn-xs btn-success" data-btn-cancel-label="取消" data-btn-cancel-icon="icon-close" data-btn-cancel-class="btn-xs btn-danger"
										dsaction="delete">
										删除 </a>
								 
                                        <a class="start" href="javascript:;"  data-toggle="confirmation" data-original-title="确定要启动数据源吗 ?"  data-placement="left"   data-singleton="true"
                                           data-btn-ok-label="确定" data-btn-ok-icon="icon-like" data-btn-ok-class="btn-xs btn-success" data-btn-cancel-label="取消" data-btn-cancel-icon="icon-close" data-btn-cancel-class="btn-xs btn-danger"
                                           dsaction="start">
                                            启动 </a>

                                        <a class="stop" href="javascript:;"  data-toggle="confirmation" data-original-title="确定要停止数据源吗 ?"  data-placement="left"   data-singleton="true"
                                           data-btn-ok-label="确定" data-btn-ok-icon="icon-like" data-btn-ok-class="btn-xs btn-success" data-btn-cancel-label="取消" data-btn-cancel-icon="icon-close" data-btn-cancel-class="btn-xs btn-danger"
                                           dsaction="stop">
                                            停止 </a>`;

            oTable.fnUpdate(opHtml, nRow, 8, false);
            oTable.fnDraw();

            initdeleteConfirm(oTable);
            initStopConfirm(oTable);
            initStartConfirm(oTable);
        }
        
        function initdeleteConfirm(oTable)
        {
        	$('[dsaction=delete]').confirmation();
        	$('[dsaction=delete]').on('confirmed.bs.confirmation', function (e) {

                e.preventDefault();

              

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
             					title = '删除数据源'+dbname+'成功！';
                                alert(title)
                                reload();
                                return;
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
        }
        function reload(){
            location.href = location.href;
        }
        function initStartConfirm(oTable)
        {
            $('[dsaction=start]').confirmation();
            $('[dsaction=start]').on('confirmed.bs.confirmation', function (e) {

                e.preventDefault();



                var nRow = $(this).parents('tr')[0];
                var jqInputs = $('td', nRow);
                var dbname = jqInputs[0].innerText;
                $.ajax({
                    type: "POST",
                    url : "startDatasource.page",
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

                        var title = '启动数据源';
                        if (msg == 'success') {
                            title = '启动数据源'+dbname+'成功！';
                            alert(title)
                            reload();
                            return;
                        } else {
                            title = responseText;
                        }

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
        }

        function initStopConfirm(oTable)
        {
            $('[dsaction=stop]').confirmation();
            $('[dsaction=stop]').on('confirmed.bs.confirmation', function (e) {

                e.preventDefault();



                var nRow = $(this).parents('tr')[0];
                var jqInputs = $('td', nRow);
                var dbname = jqInputs[0].innerText;
                $.ajax({
                    type: "POST",
                    url : "stopDatasource.page",
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

                        var title = '停止数据源';
                        if (msg == 'success') {
                            title = '停止数据源'+dbname+'成功！';
                            alert(title)
                            reload();
                            return;
                        } else {
                            title = responseText;
                        }

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
        }

        var table = $('#ds_editable');

        var oTable = table.dataTable({

            // Uncomment below line("dom" parameter) to fix the dropdown overflow issue in the datatable cells. The default datatable layout
            // setup uses scrollable div(table-scrollable) with overflow:auto to enable vertical scroll(see: assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js). 
            // So when dropdowns used the scrollable div should be removed. 
            //"dom": "<'row'<'col-md-6 col-sm-12'l><'col-md-6 col-sm-12'f>r>t<'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>",
        	paging:false,
            "lengthMenu": [
                [5, 15, 20, -1],
                [5, 15, 20, "All"] // change per page values here
            ],

            // Or you can use remote translation file
            //"language": {
            //   url: '//cdn.datatables.net/plug-ins/3cfcc339e89/i18n/Portuguese.json'
            //},

            // set the initial value
            "pageLength": 5,

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

            var aiNew = oTable.fnAddData(['test','jdbc:oracle:thin:@//localhost:1521/orcl', 'oracle.jdbc.driver.OracleDriver', 'testpdp', 'testpdp', 'SELECT 1 from dual', '测试数据源', '', '']);
            var nRow = oTable.fnGetNodes(aiNew[0]);
            editRow(oTable, nRow);
            nEditing = nRow;
            nNew = true;
        });
        initdeleteConfirm(oTable);
        initStopConfirm(oTable);
        initStartConfirm(oTable);
/**
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
            
        });**/
        
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
            } else if (nEditing == nRow && this.innerHTML.includes("保存") ) { 
                /* Editing this row and want to save it */
            	 
                saveRow(oTable, nEditing);
                nEditing = null;
              
            } else {
                /* No edit in progress - let's start one */
                editRow(oTable, nRow);
                nEditing = nRow;
            }
        });
        
        var tableColumnToggler = $('#ds_editable_column_toggler');
        //tableWrapper.find('.dataTables_length select').select2(); // initialize select2 dropdown
        

        /* handle show/hide columns*/
        $('input[type="checkbox"]', tableColumnToggler).change(function () {
            /* Get the DataTables object again - this is not a recreation, just a get of the object */
            var iCol = parseInt($(this).attr("data-column"));
            var bVis = oTable.fnSettings().aoColumns[iCol].bVisible;
            oTable.fnSetColumnVis(iCol, (bVis ? false : true));
        });
    }
     

     
    return {

        //main function to initiate the module
        init: function () {

            if (!jQuery().dataTable) {
                return;
            }

            //console.log('me 1');

            $('#reloadbuttom').click();
            //initgencodelist();
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
            
        },
        
        deletegencode:function (gencodeid,e) {
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
            
        },
        initgencodelist:function()
        {
        	initgencodelist();
        }
        ,
        deletegencode:function(genid,event)
        {
        	 deletegencode(genid,event)
        }
        ,
        readme:function(genid,event)
        {
        	 $('body').modalmanager('loading');
        	 var $modal = $('#ajax-modal');

             setTimeout(function(){
                 $modal.load('readme.page?genid='+genid, '', function(){
                 $modal.modal();
               });
             }, 1000);
             
             $modal.on('click', '.update', function(){
                 $modal.modal('loading');
                 setTimeout(function(){
                   $modal
                     .modal('loading')
                     .find('.modal-body')
                       .prepend('<div class="alert alert-info fade in">' +
                         'Updated!<button type="button" class="close" data-dismiss="alert">&times;</button>' +
                       '</div>');
                 }, 1000);
               });
        },
        
     
        downcode:function(genid,event)
        {
        	var a =  $('#downfile');
        	 a.attr("href","downcode.page?genid="+genid);
        	 a.click();
        },
        initfieldtablelist:function()
        {
        	initfieldtablelist();
        }
        
      //表格排序 
       

    };

}();
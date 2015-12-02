var TableTree = function() {

    var gtreetable = function(genid) {

    	 var tree = jQuery('#gtreetable');
        tree.gtreetable({
            'draggable': false,
            'source': function(id,oNode) {
            	if(id == '0')
            	{
            		
            	}
            	else
        		{
            		if(oNode.type == 'file')
            			return ;
        		}
            	
                return {
                    type: 'POST',
                    url: 'viewCodeFiles.page',
                    data: {
                        'id': id,'genid':genid
                    },
                    dataType: 'json',
                    error: function(XMLHttpRequest) {
                        alert(XMLHttpRequest.status + ': ' + XMLHttpRequest.responseText);
                    }
                }
            },
            
            'types': { 'default': 'glyphicon glyphicon-folder-open', folder: 'glyphicon glyphicon-folder-open'},
            
            "onSelect":function(oNode)
            {
            	
            	if(oNode.type == 'folder')
            	{
            		oNode.$ceIcon.click();
            	}
            	else
        		{
            		TableTree.viewCode(genid,oNode.id);
        		}
            	
            },
            
            "onUnselect":function(oNode)
            {
            	
            	if(oNode.type == 'folder')
            	{
            		oNode.$ceIcon.click();
            	}
            	else
        		{
            		TableTree.viewCode(genid,oNode.id);
        		}
            	
            },
            'sort': function (a, b) 
            {
            	if(a.type == 'folder' && b.type == 'folder')
            	{
            		var aName = a.name.toLowerCase();
                    var bName = b.name.toLowerCase(); 
                    return ((aName < bName) ? -1 : ((aName > bName) ? 1 : 0));
            	}
            	else if(a.type == 'file' && b.type == 'file')
            	{
            		var aName = a.name.toLowerCase();
                    var bName = b.name.toLowerCase(); 
                    return ((aName < bName) ? -1 : ((aName > bName) ? 1 : 0));
            	}
            	else if(a.type == 'folder' && b.type == 'file')
            	{
            		return -1;
            	}  
            	else if(a.type == 'file' && b.type == 'folder')
            	{
            		return 1;
            	}                            
            }
           ,
           defaultActions:{},
           "language":"zh-CN","manyroots":true, "inputWidth":"300px","showExpandIconOnEmpty":false ,cached:2
        });
        
    }

    return {

        //main function to initiate the module
        init: function(genid) {

        	 gtreetable(genid);
        },
        viewCode:function(genid,path,event)
        {
        	 $('body').modalmanager('loading');
        	 var $modal = $('#ajax-modal');

             setTimeout(function(){
                 $modal.load('viewCodeFile.page?genid='+genid+'&path='+path, '', function(){
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
        }

    };

}();
var TableTree = function() {

    var gtreetable = function(genid) {

    	 var tree = jQuery('#gtreetable');
         tree.gtreetable({
            'draggable': false,
            'source': function(id) {
            	if(id == '0')
            	{
            		
            	}
            	else
        		{
            		var oNode = tree.gtreetable.getNodeById(id);
        		}
            	alert(oNode);
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
            "onSave":function (oNode) {
                return {
                    type: 'POST',
                    url: !oNode.isSaved() ? '/index.php?r=site%2FnodeCreate' : URI('/index.php?r=site%2FnodeUpdate').addSearch({'id':oNode.getId()}).toString(),
                    data: {
                        parent: oNode.getParent(),
                        name: oNode.getName(),
                        position: oNode.getInsertPosition(),
                        related: oNode.getRelatedNodeId()
                    },
                    dataType: 'json',
                    error: function(XMLHttpRequest) {
                        alert(XMLHttpRequest.status+': '+XMLHttpRequest.responseText);
                    }
                };        
            },"onDelete":function(oNode) {
                return {
                    type: 'POST',
                    url: URI('/index.php?r=site%2FnodeDelete').addSearch({'id':oNode.getId()}).toString(),
                    dataType: 'json',
                    error: function(XMLHttpRequest) {
                        alert(XMLHttpRequest.status+': '+XMLHttpRequest.responseText);
                    }
                };        
            }
            ,"onSelect":function(oNode)
            {
            	alert(oNode);
            	return false;
            }
            
            ,"onMove":function(oSource, oDestination, position) {
                return {
                    type: 'POST',
                    url: URI('/index.php?r=site%2FnodeMove').addSearch({'id':oSource.getId()}).toString(),
                    data: {
                        related: oDestination.getId(),
                        position: position
                    },
                    dataType: 'json',
                    error: function(XMLHttpRequest) {
                        alert(XMLHttpRequest.status+': '+XMLHttpRequest.responseText);
                    }
                };        
            },"language":"zh-CN","manyroots":true, "inputWidth":"300px","showExpandIconOnEmpty":false 
        });
    }

    return {

        //main function to initiate the module
        init: function(genid) {

        	gtreetable(genid);
        }

    };

}();
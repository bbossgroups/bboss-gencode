<%@ page language="java" pageEncoding="utf-8" session="false"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>


<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	<h4 class="modal-title">${modulename }代码部署说明</h4>
</div>
<div class="modal-body">
	<div class="row">
		<div class="col-md-12">
			<pg:null actual="${msg }" evalbody="true">
				<pg:yes>${readme }</pg:yes>
				<pg:no>${msg }</pg:no>
			</pg:null>
		</div>
	</div>
</div>
<div class="modal-footer">
	<button type="button" class="btn default" data-dismiss="modal">关闭</button>
	
</div>

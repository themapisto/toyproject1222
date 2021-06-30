

##

<table id="tableCustomCPU" class="dataTable-cell dataTable-hover" style="width: 100%;">
			<thead>
				<tr>
					<th id="name1">클러스터</th>
					<th>기준 CPU</th>
					<th id="vmName">가상머신 </th>
					<th>CPU</th>
					<th>Memory</th>
					<th>Disk</th>
					<th>Network</th>
					<th>시작 일시</th>
					<th>종료 일시</th>
					<th>기간</th>
					<th>1일 횟수</th>
				</tr>
			</thead>
		</table>
  
  
  
  function getCustomCPUList(cpu, clusterId, clusterName, serviceGroupId, serviceGroupName, category, startDate, endDate, startTime, endTime) {
		var userId = '0';
		if(sessionUserApproval < USER_CHECK){
			userId = sessionUserPK;
		}
		var tableCustomCPU = $('#tableCustomCPU').addClass('nowrap').DataTable({
			dom: 'B<"dataTable-body"rt><"dataTable-footer"ifp>',
			ajax: {
				url: '/performance/selectVMOvercpuList.do',
				type: 'POST',
				dataSrc: '',
				data: {
					cpu: cpu,
					clusterId: clusterId,
					tenantId: serviceGroupId,
					category: category,
					isUserTenantMapping: isUserTenantMapping,
					startDate: startDate,
					endDate: endDate,
					startTime: startTime,
					endTime: endTime,
					id: userId
				}
			},
			columns: [
				{data: 'vmName', render: function(data, type, row) {
					data = category == 'cluster' ? clusterName : serviceGroupName;
					return data;
				}},
				{data: 'cpu', render: function(data, type, row) {
					data = cpu + ' %';
					return data;
				}},
				{data: 'vmName', render: function(data, type, row) {
					data = '<a href="#">' + data + '</a>';
					return data;
				}},
				{data: 'cpu', render: function(data, type, row) {
					data = '<span class="text-danger">' + data + ' %</span>';
					return data;
				}},
				{data: 'memory', render: function(data, type, row) {
					data = data + ' %';
					return data;
				}},
				{data: 'disk', render: function(data, type, row) {
					data = data + ' KB';
					return data;
				}},
				{data: 'network', render: function(data, type, row) {
					data = data + ' KB';
					return data;
				}},
				{data: 'startDate'},
				{data: 'endDate'},
				{data: 'cnt', render: function(data, type, row) {
					data = data * 5 + '분';
					return data;
				}},
				{data: 'co'},
			],
			language: datatables_lang,
			colReorder: true,
			stateSave: true,
			lengthMenu: [[10, 25, 50, -1], ['10', '25', '50', '전체']],
			columnDefs: [{visible: false, targets: 1}],
			buttons: [{
				extend: 'collection',
				text: '내보내기',
				className: 'btn btn-export',
				buttons: [{
					extend: 'csvHtml5',
					charset: 'UTF-8',
					bom: true,
					text: 'CSV',
					title: 'CPU 기준 성능'
				}, {
					extend: 'excelHtml5',
					text: 'Excel',
					title: 'CPU 기준 성능'
				}]
			}, {
				extend: 'pageLength',
				className: 'btn btn-page',
			}, {
				extend: 'colvis',
				text: '테이블 편집',
				className: 'btn btn-colvis'
			}]
		});
		
		page_move();
	}

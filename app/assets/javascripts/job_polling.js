$(document).ready(function () {
	var search_container = $('.search-notification');
	if (search_container) {
		var job_id = search_container.attr('data-job-id');
		if (job_id) {
			setInterval(function () {
				$.ajax({
					type: 'GET',
					url: '/job/' + job_id,
					cache: false,
					success: function (data) {
						if (data.job == 'done')
							location.reload();
					}
				})
			}, 10000);
//
//			setTimeout(function () {
//				location.reload();
//			}, 40000);
		}
	}
})

/**
 * 
 */

const button = document.getElementById('button');

$('#button').click(function(){
	$.get('/api/getDailyBoxOffice',function(result){
		if(result){
			console.log(result.boxOfficeResult);
		}
	});
})
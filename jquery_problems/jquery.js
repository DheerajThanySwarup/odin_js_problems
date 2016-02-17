$(document).ready(function() {
	$('body').prepend('<div class="container" align="center"></div>')

	$('.container').prepend('<center><button onClick="newGrid(); return false">New Grid</button></center>')
		.append('<ul></ul>')
		.append('<ul></ul>')
		.append('<ul></ul>')
		.append('<ul></ul>')

	$('ul').append('<li></li>')
		.append('<li></li>')
		.append('<li></li>')
		.append('<li></li>')

	$('li').css({
		display: 'inline-block',
		'list-style-type': 'none',
		height: '25px',
		width: '25px',
		'border-width': '1px',
		'border': '1px solid #4090db',
		margin: '0 1px',
		'box-sizing': 'border-box'
	});

	$('li').mouseenter(function() {
		$(this).css('background-color', '#4090db');
	});

	$('li').mouseleave(function() {
		$(this).css('background-color','white');
	});

	$('.container').css({
		margin: '0 auto'
	});

	$('ul').css({
		padding: '0',
		margin: '0'
	});

	$('button').css({
		'cursor': 'pointer',
		margin: '10px 0',
		padding: '4px',
		width: '210px',
		'background-color': '#4090db',
		'border-radius': '4px',
		'border-width': '1px',
		'font-size': '16px',
		color: 'white',
		'font-family': 'sans-serif'
	});

});

function newGrid() {

	$('li').css('background-color' , 'white');
	$('.container').remove()
	$('body').prepend('<div class="container" align="center"></div>')
	
	var width;
	do{
		width = prompt('Enter width of the grid ( <=35 )');
	}while(width > 35);

	var height;
	do{
		height = prompt('Enter height of the grid ( <=20 )');
	}while(height > 20); 

	for (var i=0; i<height; i++) {
		$('.container').append('<ul></ul>');
	}

	for (var i=0; i<width; i++) {
		$('ul').append('<li></li>');
	}

	$('.container').prepend('<center><button onClick="newGrid(); return false">New Grid</button><center>')

	$('li').css({
		display: 'inline-block',
		'list-style-type': 'none',
		height: '25px',
		width: '25px',
		'border-width': '1px',
		'border': '1px solid #4090db',
		margin: '0 1px',
		'box-sizing': 'border-box'
	});

	$('li').mouseenter(function() {
		$(this).css('background-color','#4090db');
	});

	$('li').mouseleave(function() {
		$(this).css('background-color','white');
	});

	$('.container').css({
		margin: '0 auto'
	});

	$('ul').css({
		padding: '0',
		margin: '0'
	});

	$('button').css({
		'cursor': 'pointer',
		margin: '10px 0',
		padding: '4px',
		width: '210px',
		'background-color': '#4090db',
		'border-radius': '4px',
		'border-width': '1px',
		'font-size': '16px',
		color: 'white',
		'font-family': 'sans-serif'
	});
};
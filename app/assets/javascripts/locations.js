$(function() {
		var addresspickerMap = $( "#addresspicker_map" ).addresspicker({
															regionBias: "uk",
															elements: {
															map: "#map",
															lat: "#location_latitude",
															lng: "#location_longitude",
															locality: '#location_locality',
															country: '#location_country'
															}
});	
	var gmarker = addresspickerMap.addresspicker( "marker");
	gmarker.setVisible(true);
	addresspickerMap.addresspicker( "updatePosition");
});

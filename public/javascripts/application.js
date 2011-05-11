var hyd = {
	EXPANDED      : "&#9660;",
	COLLAPSED     : "&#9658;",
	request       : null,
	autocompleter : null,
	base_url      : "",

	display_login_form: function() {
		Effect.toggle('login-form', 'slide', { duration: 0.25 });
	},
	set_status: function(status, user, date) {
		$(status).className = 'rating smileys-smiley_' + status;
		var updated_status = status.charAt(0).toUpperCase() + status.slice(1);
		$('status_rating').value = updated_status;
	}

}
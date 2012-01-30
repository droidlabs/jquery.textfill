(function($) {
	$.fn.textfill = function (options) {
		var defaults = {
		      maxFontSize: 100,
		      innerTag: 'h1',
		      percent: 100,
		      height: null,
		      width: null,
		      lineHeight: null
		    };
		options = jQuery.extend(defaults, options);
		this.each(function() {
		  var $text = $(options.innerTag + ':visible:first', this),
		      $helper = $(this).find('.textfill-helper-' + options.innerTag),
			    fontSize = options.maxFontSize,
			    width = options.width || $text.width(),
			    maxWidth = width * (options.percent / 100) - 5,
			    textWidth, textHeight, maxHeight;
			if (!$helper.length) {
			  $helper = $('<span>', {'class': 'textfill-helper'});
			  $helper.css({position: 'absolute', visibility: 'hidden'})
			  $helper.insertAfter($text);
			}
			$helper.html($text.html())
			do {
			  maxHeight = options.height || (options.lineHeight || parseInt($helper.css('line-height'), 10) + 2);
				$helper.css('font-size', fontSize);
				textWidth = $helper.width();
				textHeight = $helper.height();
				fontSize = fontSize - (fontSize < 30 ? 1 : 2);
			} while ((textWidth > maxWidth || textHeight > maxHeight) && fontSize > 9);
			$text.css('font-size', fontSize);
		});
		return this;
	};
})(jQuery);
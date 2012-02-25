#
# jQuery Textfill Plugin
# https://github.com/droidlabs/jquery.textfill
# Copyright (c) 2011-2012 Droid Labs
# Licenced under [MIT](http://www.opensource.org/licenses/mit-license.php).
#
(($) ->
  $.fn.textfill = (options) ->
    defaults =
      maxFontSize: 100
      innerTag: "h1"
      percent: 100
      height: null
      width: null
      lineHeight: null

    options = jQuery.extend(defaults, options)
    @each ->
      $text = $(options.innerTag + ":visible:first", this)
      $helper = $(this).find(".textfill-helper-" + options.innerTag)
      fontSize = options.maxFontSize
      width = options.width or $text.width()
      maxWidth = width * (options.percent / 100) - 5
      unless $helper.length
        $helper = $("<span>",
          class: "textfill-helper-" + options.innerTag
        )
        $helper.css
          position: "absolute"
          visibility: "hidden"

        $helper.insertAfter $text
      $helper.html $text.html()
      loop
        if options.lineHeight
          lineHeight = options.lineHeight
        else
          lineHeightTmp = parseFloat($helper.css("line-height"), 10)
          lineHeight = (if lineHeightTmp > 3 then lineHeightTmp else fontSize * lineHeightTmp)
        maxHeight = options.height or (lineHeight + 2)
        $helper.css "font-size", fontSize
        textWidth = $helper.width()
        textHeight = $helper.height()
        fontSize = fontSize - (if fontSize < 30 then 1 else 2)
        break unless (textWidth > maxWidth or textHeight > maxHeight) and fontSize > 9
      $text.css("font-size", fontSize)

    this
)(jQuery)
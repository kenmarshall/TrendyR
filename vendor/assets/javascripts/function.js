$.fn.correctLines = function( maxLine, moreText ) {
	return this.each(function( index, self ) {
		var temp, classes, i, lineHeight;
		maxLine = ( temp = /^(?:.*\s)?fixline_([\d]+)(?:\s.*)?$/.exec( self.className ) ) && temp[1] || maxLine || 3;
		moreText = moreText || '...<br />';
		var od = $( self ).css( "display" );
		var clone = $( self ).css( "display", "block" ).clone( true ).
				css( {"height": "auto", "position": "absolute", "width": self.offsetWidth + "px" } ).html("");
		$( self ).css( "display", od ).after( clone );

		var height = 0,
			width = self.offsetWidth,
			lines = 0,
			lastHeight = 0,
			startWord = 0,
			endWord = -1,
			txt = self.innerHTML,
			part = [];
			while( /(<.*)\s(.*>)/g.exec( txt ) ) {
				txt = txt.replace(/(<.*)\s(.*>)/g, '$1&jftF767Tgjk56&$2');
			}
			txt = txt.split(' ');

		for( i = 0; i < txt.length; i++ ) {
			txt[i] = txt[i].replace(/&jftF767Tgjk56&/g, ' ');
			clone[0].innerHTML += txt[ i ] + ' ';
			if ( clone[0].clientHeight > lastHeight ) {
				height = lastHeight;
				startWord = endWord + 1;
				endWord = i - 1;
				lastHeight = clone[0].offsetHeight;
				if ( ++lines > maxLine ) {
					break;
				}
			}
		}
		if ( lines > maxLine ) {
			$( self ).css({height: height + "px", overflowY: 'hidden'});
			part = txt.slice( startWord, endWord + 1 );
			height = clone.html( part.join(' ') )[0].offsetHeight;
			for( i = part.length - 1; i >= 0; i-- ) {

				clone.html( part.join(' ') + moreText );

				if ( clone[0].offsetHeight > height ) {
					part.splice( i, 1 );
					endWord--;
				} else {
					break;
				}
			}
			txt[ endWord ] += moreText;

			self.innerHTML = txt.join(" ");
		} else {
			$( self ).css({height: "auto"});
		}
		clone.remove();
	});
}		

var hideBlock = function hideBlock ($mainBlock, $hideBlock){
	$mainBlock.click(function(e) {
		if ($hideBlock.css('display') != 'block') {
			$hideBlock.show();
			var firstClick = true;
	        $(document).bind('click.myEvent', function(e) {
	            if (!firstClick && $(e.target).closest($hideBlock).length == 0) {
	                $hideBlock.hide();
	                $(document).unbind('click.myEvent');
	            }
	            firstClick = false;
	        });
		}
		e.preventDefault();
	})
}

var resizeFooter = function ($mainBlock) {
		var $footer 	= $('footer'),
			$windows 	= window.innerHeight;
	if($mainBlock.height() + $footer.height() < $windows){
		$mainBlock.height($windows - $footer.height());
	}
}
// [ Height ]
$.fn.equivalent = function (){
	var $blocks = $(this),
		maxH    = $blocks.eq(0).height(); 			
	$blocks.each(function(){
		maxH = ( $(this).height() > maxH ) ? $(this).height() : maxH;				
	});
	$blocks.height(maxH); 
}
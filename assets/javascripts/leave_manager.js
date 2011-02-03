document.observe("dom:loaded", function() {
  $$(".clickable").each( function(elem){
    elem.observe('click', function(){ markDay( $(this) ) });
  } );
});

function markDay(d) {
  if( d.hasClassName('leave') ) {
    deleteDay(d);
  }else {
    saveDay(d);
  }
}
  

function markUpDay(d) {
  d.addClassName('leave');
  //markPeriod(d);
  //updateLeaveCounter();
}

function markDownDay(d) {
  d.removeClassName('leave');
  //unmarkPeriod(d);
  //updateLeaveCounter();
}

function markPeriod(d) {
  nxt = d;
  do {
    markDayAsPeriod(nxt,'fwd-period');
    nxt = nextDay(nxt);
  } while( isFree(nxt) )  

  prev = d;
  do {
    markDayAsPeriod(prev,'rvs-period')
    prev = prevDay(prev)
  } while( isFree(prev) )
}

function unmarkPeriod(d) {
  nxt = d;
  do {
    unmarkDayAsPeriod( nxt, 'fwd-period', !nxt.hasClass('rvs-period') );
    nxt = nextDay(nxt);
  } while( isFree(nxt) )  
    
  prev = d;
  do {
    unmarkDayAsPeriod( prev,'rvs-period', !prev.hasClass('fwd-period') );
    prev = prevDay(prev);
  } while( isFree(prev) )
}

function nextDay(d) {
  try {
    if( d.hasClass('last-day-of-month') ) {
      nxt = d.parent().parent().next().next().find("td div.day").first();
    } else { nxt = d.parent().next('td').children().first(); }
    return nxt;
  } catch(e) { return null; }
}

function prevDay(d) {
  try {
    if( d.hasClass('first-day-of-month') ) {
      nxt = d.parent().parent().prev().prev().find("td div.day").last();
    } else {
      nxt = d.parent().prev('td').children().first();
    }
    return nxt;
  } catch(e) {
    return null;
  }
}

function isFree(d) {
  if( d == null ) return false;
  return (d.hasClass("weekend") || d.hasClass("holiday"))
}
  
function markDayAsPeriod(d, class) {
  d.addClass("period "+class);
}
  
function unmarkDayAsPeriod(d, class, cond) {
  if(cond) d.removeClass('period');
  d.removeClass(class);
}

function updateLeaveCounter() {
  //$("#leave-count").text( $(".leave").length );
  //$("#period-count").text( $(".period").length );
}

function saveDay(d) {
  var url = "/leaves.js"
  new Ajax.Request(url, {
    method: 'POST',
    parameters: { "leave[date]": d.readAttribute('id') }
  });
}
  
function deleteDay(d) {
  var url = "/leaves/"+d.readAttribute('id')+".js";
  new Ajax.Request(url, {
    method: 'DELETE'
  });
}


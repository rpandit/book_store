$(document).ready(function() {
   
  var oTable = $('#media_table').dataTable( {
                  sPaginationType: "full_numbers",
                  bJQueryUI: true,
                  bProcessing: true,
                  bServerSide: true,
                  sAjaxSource: $('#media_table').data('source'),
                  "fnRowCallback": function( nRow, aData, iDisplayIndex ) {
                      var id = aData[0];
                      $(nRow).attr("id",id);
                      return nRow;
                    }
                  });   
             
  oTable.fnSetColumnVis( 0, false );
  
  $("#media_table tbody").click(function(event) {
      $(oTable.fnSettings().aoData).each(function (){
        $(this.nTr).removeClass('row_selected');
      });
      $(event.target.parentNode).addClass('row_selected');
  });
  
  //$("#media_table tbody").keydown(function (e) {
   
  $(document).keydown(function (e) {
    var currentRow = $(".row_selected").get(0);
    if (e.keyCode == 40) { //arrow down
       $(currentRow).next().addClass("row_selected");
       $(currentRow).removeClass("row_selected");
    } else if(e.keyCode == 38){//arrow up
      $(currentRow).prev().addClass("row_selected");
      $(currentRow).removeClass("row_selected");
    } else if(e.keyCode == 13){//enter
      var id = $(currentRow).attr("id");
      window.location.href = '/media/'+id;
    }
   
  });
  
  $("#media_table tbody").dblclick(function(event) {
    var id = $(event.target.parentNode).attr("id");
    window.location.href = '/media/'+id;
    
  });
  //$('#media_table_filter input').attr("data-autocomplete",'/media/autocomplete_medium_title');
 
  
} );
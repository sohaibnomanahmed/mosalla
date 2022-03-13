function atEdit(e) {
    const email = "--projectemail--"
    const key = "--privatekey--"
    const projectId = "--projectid--"
    var firestore = FirestoreApp.getFirestore(email, key, projectId)
  
    // Get data from the spreadsheet
    // Application -> SpreadSheet -> Sheet -> Range of Cells
    //var ss = SpreadsheetApp.getActiveSpreadsheet()
    //var sheet = ss.getActiveSheet()
  
    var sheet = e.source.getActiveSheet()
    var range = e.range
    var names = sheet.getRange(1, 1, 1, 7).getValues()
    var timeZone = e.source.getSpreadsheetTimeZone()
  
    //var valueLength = values[0].length;
    //if (valueLength < 7){
    //  var ui = SpreadsheetApp.getUi();
    //  ui.alert('Error', 'Select all columns including date and all prayers times', ui.ButtonSet.OK);
    //  return
    //}
  
    for (var i=range.getRow(); i<range.getLastRow() + 1; i++){
      var prayers = sheet.getRange(i, 1, 1, 7).getValues()
      
      console.log(prayers)
      var data = {}
      for (var j=0; j<7; j++){
        var value = prayers[0][j]
        if (value === ''){
          // if no value then add null istead of empty string
          data[names[0][j]] = null
        } else {
          // for the date we want to add the date itself
          data[names[0][j]] = value
        } 
      }
      var id = data['Date'].replaceAll("/", "-")
    
      // insert data into firestore, merge so old data dont get updated again?? dont need to select if so
      firestore.updateDocument("mosalla/" + sheet.getName() + "/prayer_times/" + id, data, true)
    }
  }
  
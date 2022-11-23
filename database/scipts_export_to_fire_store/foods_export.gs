function mainFunc() {
  const email = "YOUR_CLIENT_EMAIL";
  const key = "YOUR_PRIVATE_KEY";
  const projectId = "YOUR_PROJECT_ID";
  var firestore = FirestoreApp.getFirestore(email, key, projectId);

  // get document data from ther spreadsheet
  var ss = SpreadsheetApp.getActiveSpreadsheet();
  var sheetname = "menus";
  var sheet = ss.getSheetByName(sheetname);
  // get the last row and column in order to define range
  var sheetLR = sheet.getLastRow(); // get the last row
  var sheetLC = sheet.getLastColumn(); // get the last column

  var dataSR = 2; // the first row of data
  // define the data range
  var sourceRange = sheet.getRange(2, 1, sheetLR - dataSR + 1, sheetLC);

  // get the data
  var data = sourceRange.getValues();
  // get the number of length of the object in order to establish a loop value
  var sourceLen = data.length;

  // Loop through the rows
  for (var i = 0; i < sourceLen; i++) {
    var doc = {};
    if (data[i][1] !== '') {
      doc.id = data[i][0];
      doc.img = data[i][1];
      doc.name = data[i][2];
      doc.dsc = data[i][3];
      doc.price = data[i][4];
      doc.rate = data[i][5];
      doc.country = data[i][6];
      doc.category = data[i][7];

      console.log(i);
      firestore.createDocument("foods", doc);

    }
  }
}
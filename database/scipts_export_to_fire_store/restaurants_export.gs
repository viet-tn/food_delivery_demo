function myFunction() {
  const email = "YOUR_CLIENT_EMAIL";
  const key = "YOUR_PRIVATE_KEY";
  const projectId = "YOUR_PROJECT_ID";
  var firestore = FirestoreApp.getFirestore(email, key, projectId);

  // get document data from ther spreadsheet
  var ss = SpreadsheetApp.getActiveSpreadsheet();
  var restaurantsSheet = ss.getSheetByName('restaurants');
  var foodIdsSheet = ss.getSheetByName('food ids');
  // get the last row and column in order to define range
  var restaurantsLR = restaurantsSheet.getLastRow(); // get the last row
  var resttaurantsLC = restaurantsSheet.getLastColumn();
  var foodIdsLR = foodIdsSheet.getLastRow(); // get the last row
  var foodIdsLC = foodIdsSheet.getLastColumn();

  var restaurantsData = restaurantsSheet.getRange(1, 1, restaurantsLR, resttaurantsLC).getValues();
  var foodIdsData = foodIdsSheet.getRange(1, 1, foodIdsLR, foodIdsLC).getValues();


  var init = 0;
  var j = 0;
  var foodCount = Math.floor(foodIdsData.length / restaurantsData.length);

  for (var i = 0; i < restaurantsData.length; i++) {
    var doc = {};
    doc.id = restaurantsData[i][0];
    doc.name = restaurantsData[i][1];
    doc.url = restaurantsData[i][2];
    menu = [];
    var food = {};

    for (; j < init + foodCount; j++) {
      menu.push({ 'food_id': foodIdsData[j][0] });
    }
    j = init + foodCount;
    init = init + foodCount;
    doc.menu = menu;
    firestore.createDocument("restaurants", doc);
    if (init + foodCount >= foodIdsData.length) break;
  }
}

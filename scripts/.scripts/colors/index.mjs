#!node 

import getPixels from "get-pixels";

getPixels("testImg.jpg", function(err, pixels) {
  if(err) {
    console.error(err);
    return;
  }
  console.log("\n\n", pixels.data.toString());
});

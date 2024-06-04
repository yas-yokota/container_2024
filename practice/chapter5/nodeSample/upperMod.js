exports.OutputJson = function (inLine) {
  let outLine = inLine.toUpperCase();
  let myData = {input: inLine, output: outLine};
  let myDataJson = JSON.stringify(myData) ;
  return myDataJson;
}

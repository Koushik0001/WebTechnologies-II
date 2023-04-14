function calculateFactorials(num) {
    const tableData = [];
  
    for (let i = 1, fact = 1; i <= num; i++) {
      fact *= i;
      tableData.push(fact);
    }
  
    return tableData;
  }
  
  self.onmessage = function(event) {
    const num = event.data;
    const tableData = calculateFactorials(num);
    self.postMessage(tableData);
  };
  
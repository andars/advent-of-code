var fs = require('fs');

function sumNumbers(object, part) {
    var sum = 0;
    for (var key in object) {
        if (object[key] === 'red' && !Array.isArray(object) && part) {
            return 0;
        }
        if (typeof object[key] === 'object') {
            sum += sumNumbers(object[key], part); 
        }        
        if (Number.isInteger(object[key])) {
            sum += object[key];
        }
    }
    return sum;
}

fs.readFile('inputs/day12.txt', function(err, contents) {
    var obj = JSON.parse(contents);
    console.log(sumNumbers(obj, false));
    console.log(sumNumbers(obj, true));
});

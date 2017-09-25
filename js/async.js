var job1 = function(cb) {
  setTimeout(function() { cb('first'); }, 900);
};

var job2 = function(cb) {
  setTimeout(function() { cb('second'); }, 100);
};

var job3 = function(cb) {
  setTimeout(function() { cb('third'); }, 300);
};

var funcs = [job1, job2, job3];
// output => [first, second, third]

var doJobs = ( (funcs, cb) => {
  var storage = [];
  var count = 0;
  funcs.forEach( (func, idx) => {
    func(string => {
      storage[idx] = string;
      count++;
      if (funcs.length === count) {
        cb(storage);
      }
    })
  })
})


doJobs(funcs, array => {
  console.log(array);
})






// var foo = []
// foo[1] = 2 => [nil, 2] =>

// var doJobs = ( (funcs, cb) => {
//   var storage = [];
//   var count = 0;
//   funcs.forEach( (func, idx) => {
//     func(string) => {
//       storage[idx] = string;
//       count++;
//       if (funcs.length === count) {
//         cb(storage);
//       }
//     }
//   })
// })
//
// doJobs( funcs, array => {
//   console.log(array);
// })
//
// for (var i = 0; i < array.length; i++) {
//   array[i]
// }












var doJobs = (funcs, cb) => {
  funcs.forEach ( func => {
    func( string => {
      cb(string)
    })
  })
}

doJobs(funcs, el => {
  console.log(el);
}
})

















var doJobs = (funcs, cb) => {
    var storage = []
    var count = 0
    funcs.forEach( (func, idx) => {
        func( (string) => {
            storage[idx] = string;
            count++;
            if (funcs.length === count) {
                cb(storage)
            }
        });
    })
}




doJobs(funcs, array => {
    console.log(array)
});

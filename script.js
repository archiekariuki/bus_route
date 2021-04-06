





// function pyramid(n) {
//     const midpoint = Math.floor((2 * n - 1) /2);
    
//   for(let row = 0; row < n ; row++){
//       let level = '';
//       for(let column = 0; column < 2 * n - 1; column++){
//           if(midpoint - row <= column && midpoint + row >= column){
//               level += '#';
//           } else{
//               level += ' ';
//           }
//       }
//       console.log(level);
//   }
    
// }
// console.log(pyramid(3));

// /* Function for Priniting Steps */
// function steps(n) {
//     for(let row = 0; row < n; row++){
//         let stair = '';
        
//      for (let column = 0; column < n; column++){
//          if(column <= row){
//              stair += '#';
//          }else{
//              stair += ' ';
//          }
//      }
//      console.log(stair);
//     }
  
// }



// /* Another Capitol function */
// function capitol(str){
//     let result = str[0].toUpperCase();

//     for(i = 1; i < str.length; i++){
//         if(str[i-1]=== " "){
//              result += str[i].toUpperCase();
//         }else{
//              result += str[i];
//         }
//     }
//     return result;
// }

// console.log(capitol('hello there people'))







/* Function for Capitolization */

// function capitol(str){
    
//     const words = [];
   
//    for(let word of str.split(' ')){
//        words.push(word[0].toUpperCase() + word.slice(1));
//    }
//    return words.join(' ');
    

// }
// console.log(capitol('hello there people'));

/* Function for Array Chunk */

// function chunk(array, size){
//   const chunked = [];
   
// for( let element of array){
//     const last = chunked[chunked.length - 1];

//     if(!last || last.length === size){
//        chunked.push([element]);
//     } else{
//         last.push(element);
//     }
// }
// return chunked;
// }

// console.log(chunk([1,2,3,4], 2));

/* Anagram function */

// function anagrams(stringA, stringB) {
//     const charMapA = buildCharMap(stringA);
//     const charMapB = buildCharMap(stringB);
    
//     if(Object.keys(charMapA).length !== Object.keys(charMapB).length){
//         return false;
//     }
    
//     for (let char in charMapA){
//         if(charMapA[char] !== charMapB[char]){
//             return false;
//         }
//     }
    
//     return true;
    
// }
// function buildCharMap(str){
//     const charMap = {};
//     for(let char of str.replace(/[^\w]/g, "").toLowerCase()){
//         charMap[char]= charMap[char]+1 || 1;
//     }
//     return charMap;
// }
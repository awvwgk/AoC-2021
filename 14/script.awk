BEGIN {
   FS = ""
}
NR == 1 {
   for(ii = 1; ii < NF; ii++)
      string[$ii,$(ii+1)]++
   first = $1
   last = $NF
}
NR > 2 {
   grow[$1,$2] = $NF
}

function poly(string) {
   delete input
   for(kk in string) input[kk] = string[kk]
   delete string
   for(kk in input) {
      split(kk, pair, SUBSEP)
      new = grow[kk]
      string[pair[1],new] += input[kk]
      string[new,pair[2]] += input[kk]
   }
}

function amax(array) {
   max = 0
   for(ii in array)
      max = array[ii] > max ? array[ii] : max
   return max
}

function amin(array) {
   min = 9999999999999
   for(ii in array)
      min = array[ii] < min ? array[ii] : min
   return min
}

function acount(array, str, first, last) {
   delete array
   array[first]++
   array[last]++
   for(jj in str) {
      split(jj, pair, SUBSEP)
      array[pair[1]] += str[jj]
      array[pair[2]] += str[jj]
   }
}

END {
   for(step = 1; step <= 10; step++)
      poly(string)
   acount(count, string, first, last)
   print (amax(count) - amin(count)) / 2

   for(step = 1; step <= 30; step++)
      poly(string)
   acount(count, string, first, last)
   print (amax(count) - amin(count)) / 2
}

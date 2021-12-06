BEGIN {
   FS = ","
}
NR == 1 {
   n = NF
   for (i=1; i<=n; i++) {
      input[i] = $i
   }
   FS = " "
}

function in_array(value, array) {
   for (ii in array)
      if (array[ii] == value) return ii
   return 0
}

function complete(array) {
   for (ic=1; ic<=5; ic++) {
      r = 0
      c = 0
      for (jc=1; jc<=5; jc++) {
         r += array[ic,jc]
         c += array[jc,ic]
      }
      if (c == -5 || r == -5) return 1
   }
   return 0
}

function score(array) {
   lscore = 0
   for (jj in array)
      if (array[jj] > 0) lscore += array[jj]
   return lscore
}

NF == 5 {
   for (i=1; i<=NF; i++)
      array[row%5+1,i] = $i
   row++
}
NF == 5 && row % 5 == 0 {
   for (i=1; i<=n; i++) {
      pos = in_array(input[i], array)
      last = array[pos]
      if (pos) array[pos] = -1
      if (complete(array)) {
         this_score = score(array) * input[i]
         scores[i] = this_score
         break
      }
   }
}

END {
   minv = 0
   maxv = -1
   for (val in scores) {
      if (minv == 0) minv = val
      maxv = val > maxv ? val : maxv
   }
   print "[1]:", scores[minv]
   print "[2]:", scores[maxv]
}

BEGIN {
   FS=","
}
{
   gsub(/ -> /,",",$0)
}
$1 == $3 {
   start = $4 > $2 ? $2 : $4
   end = $4 > $2 ? $4 : $2
   for (y=start; y<=end; y++) {
      field[$1,y]++
   }
}
$2 == $4 {
   start = $3 > $1 ? $1 : $3
   end = $3 > $1 ? $3 : $1
   for (x=start; x<=end; x++) {
      field[x,$2]++
   }
}
$1 != $3 && $2 != $4 {
   x = $1 > $3 ? -1 : 1
   y = $2 > $4 ? -1 : 1
   end = ($3 - $1)*x
   for (d=0; d<=end; d++) {
      field[$1+d*x,$2+d*y]++
   }
}
END {
   for (xy in field) {
      if (field[xy] > 1) {
         smoke++
      }
   }
   print smoke
}

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
END {
   for (xy in field) {
      if (field[xy] > 1) {
         smoke++
      }
   }
   print smoke
}

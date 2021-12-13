BEGIN {
   FS = ","
}
$1 ~ /[0-9]+/ {
   dot[$1,$2]++
}
NF == 0 {
   FS = "="
}
function mirror(val, pos) {
   return 2*pos - val
}
$1 ~ /[xy]$/ {
   for (i in dot) {
      split(i, j, SUBSEP)
      if ($1 ~ /x$/ && j[1] > $2) {
         maxx = $2
         j[1] = mirror(j[1], $2)
         dot[j[1],j[2]] = dot[i]
         delete dot[i]
      }
      if ($1 ~ /y$/ && j[2] > $2) {
         maxy = $2
         j[2] = mirror(j[2], $2)
         dot[j[1],j[2]] = dot[i]
         delete dot[i]
      }
   }
   if (!first++) print length(dot)
}
END {
   for (y = 0; y <= maxy; y++) {
      for (x = 0; x <= maxx; x++) {
         if (dot[x,y] > 0) {
            printf "#"
         } else {
            printf "."
         }
      }
      printf "\n"
   }
}

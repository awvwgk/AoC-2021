{
   a[NR] += $1
   a[NR-1] += $1
   a[NR-2] += $1
}
NR > 3 {
   if (a[NR-2] > a[NR-3]) {
      total++
   }
}
END {
   print total
}

last > 0 {
   if ($1 > last) {
      total++
   }
}
{
   last = $1
}
END {
   print total
}

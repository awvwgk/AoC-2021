/forward/ {
   h += $2
   d += $2 * a
}
/down/ {
   a += $2
}
/up/ {
   a -= $2
}
END {
   print h * d
}

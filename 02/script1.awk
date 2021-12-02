/forward/ {
   h += $2
}
/down/ {
   d += $2
}
/up/ {
   d -= $2
}
END {
   print h * d
}

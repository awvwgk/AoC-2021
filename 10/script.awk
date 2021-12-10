BEGIN {
   FS=""
}
{
   for (i=1; i<=NF; i++)
      gsub(/\(\)|\[\]|\{\}|<>/, "")
   save = $0
   gsub(/[\(\[\{<]/, "")
}
$1 ~ /\)/ { error += 3 }
$1 ~ /\]/ { error += 57 }
$1 ~ /\}/ { error += 1197 }
$1 ~ />/  { error += 25137 }
NF == 0 { $0 = save }
$1 ~ /[\(\[\{<]/ {
   complete = 0
   for (i=NF; i; i--) {
      complete *= 5
      if ($i ~ /\(/) complete += 1
      if ($i ~ /\[/) complete += 2
      if ($i ~ /\{/) complete += 3
      if ($i ~ /</)  complete += 4
   }
   score[NR] = complete
}
END {
   print "[1]:", error
   n = int(asort(score)/2 + 1)
   for (i in score) {
      if (++run == n)
         print "[2]:", score[i]
   }
}

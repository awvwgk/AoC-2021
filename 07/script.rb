arr = ARGF.read.chomp.split(",").map(&:to_i)

minf1, minf2 = 9999, 9999
((arr.min)..(arr.max)).each do |shift|
  tmp = arr.map{|y| y = (y - shift).abs}
  minf1, minf2 = [tmp.sum, minf1].min, [tmp.map{|y| y = y*(y+1)/2}.sum, minf2].min
end
puts(minf1, minf2)

require 'set'

$input = Hash.new(Array.new)
ARGF.read.split("\n").each do |line|
  a, b = line.split("-").map(&:to_sym)
  $input[a] += [b]
  $input[b] += [a]
end

def search node, done, exclude
  return 1 if node == :end
  done.add(node) if node == node.downcase
  count = $input[node].reject {|n| done.include? n }.map do |n|
    search(n, done, exclude)
  end
  count += $input[node].select {|n| done.include? n and n != :start }.map do |n|
    search(n, done, n)
  end if exclude == :start
  done.delete(node) if node != exclude
  return count.sum
end

puts "[1]: %s" % search(:start, Set.new, nil)
puts "[2]: %s" % search(:start, Set.new, :start)

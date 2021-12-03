implicit none
character(len=64) :: arg
integer :: io, stat, total, i
integer, allocatable :: line(:), counter(:), list(:, :)

call get_command_argument(1, arg)
open(file=arg, newunit=io, iostat=stat)
total = 0
read(io, '(a)', iostat=stat) arg
line = merge(1, 0, [(arg(i:i) == "1", i = 1, len_trim(arg))])
counter = spread(0, 1, size(line))
allocate(list(0, 0))
do while(stat == 0)
   total = total + 1
   counter = counter + line
   list = reshape([list, line], [size(line), size(list, 2)+1])
   read(io, '(*(i1))', iostat=stat) line
end do
close(io)

block
   integer :: gam, eps
   gam = binary(counter > total - counter)
   eps = binary(counter < total - counter)
   print *, gam, eps, gam*eps
end block

block
   integer :: pos, one, zero, sel, o2, co2
   integer, allocatable :: sub(:, :)
   sub = list
   pos = 0
   do while(size(sub, 2) > 1)
      pos = pos + 1
      one = count(sub(pos, :) == 1)
      zero = count(sub(pos, :) == 0)
      sel = merge(1, 0, one >= zero)
      sub = reshape(pack(sub, spread(sub(pos, :) == sel, 1, size(list, 1))), &
         &          [size(list, 1), merge(one, zero, one >= zero)])
   end do
   o2 = binary(sub(:, 1) == 1)

   sub = list
   pos = 0
   do while(size(sub, 2) > 1)
      pos = pos + 1
      one = count(sub(pos, :) == 1)
      zero = count(sub(pos, :) == 0)
      sel = merge(1, 0, one < zero)
      sub = reshape(pack(sub, spread(sub(pos, :) == sel, 1, size(list, 1))), &
         &          [size(list, 1), merge(one, zero, one < zero)])
   end do
   co2 = binary(sub(:, 1) == 1)
   print *, o2, co2, o2 * co2
end block
contains
pure function binary(bits) result(num)
   logical, intent(in) :: bits(:)
   integer :: num
   integer :: i
   num = sum([(merge(2**i, 0, bits(size(bits)-i)), i = 0, size(bits) - 1)])
end function binary
end

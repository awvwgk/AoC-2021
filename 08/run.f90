implicit none
character(len=7) :: input(10), output(4), dummy
character, parameter :: chars(7) = ["a", "b", "c", "d", "e", "f", "g"]
logical :: set(7, 10), val(7), decode(7, 0:9)
character(len=64) :: arg
integer :: io, stat, i, j, r1, r2

r1 = 0
r2 = 0
call get_command_argument(1, arg)
open(newunit=io, file=arg, status='old', iostat=stat)
read(io, *, iostat=stat) input, dummy, output
do while (stat == 0)
   decode(:, :) = .false.
   do i = 1, 10
      set(:, i) = [(scan(input(i), chars(j)) > 0, j = 1, size(chars))]
      select case(count(set(:, i)))
      case(2); decode(:, 1) = set(:, i)
      case(4); decode(:, 4) = set(:, i)
      case(3); decode(:, 7) = set(:, i)
      case(7); decode(:, 8) = set(:, i)
      end select
   end do
   do i = 1, 10
      if (count(set(:, i)) == 6) then
         if (count(set(:, i) .and. decode(:, 4)) == 4) then
            decode(:, 9) = set(:, i)
         else
            decode(:, merge(0, 6, count(set(:, i) .and. decode(:, 1)) == 2)) = set(:, i)
         end if
      end if
   end do
   decode(:, 5) = decode(:, 9) .and. decode(:, 6)
   do i = 1, 10
      if (count(set(:, i)) == 5) then
         select case(count(set(:, i) .and. decode(:, 5)))
         case(4); decode(:, 3) = set(:, i)
         case(3); decode(:, 2) = set(:, i)
         end select
      end if
   end do

   do i = 1, 4
      val = [(scan(output(i), chars(j)) > 0, j = 1, size(chars))]
      do j = 0, 9
         if (all(val .eqv. decode(:, j))) exit
      end do
      r1 = r1 + count(j == [1, 4, 7, 8])
      r2 = r2 + 10**(4-i)*j
   end do

   read(io, *, iostat=stat) input, dummy, output
end do
close(io)

print '(a, 1x, i0)', "[1]:", r1
print '(a, 1x, i0)', "[2]:", r2
end

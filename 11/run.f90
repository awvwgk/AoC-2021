implicit none
integer :: input(0:11, 0:11), io, flash, step, rep, i, j
character(len=64) :: arg
call get_command_argument(1, arg)
open(newunit=io, file=arg, status='old')
read(io, '(10i1)') input(1:10, 1:10)
close(io)

rep = 0
flash = 0
step = 0
do while(rep == 0)
   step = step + 1
   input(1:10, 1:10) = input(1:10, 1:10) + 1

   do while (any(input(1:10, 1:10) > 9))
      do i = 1, 10
         do j = 1, 10
            if (input(j, i) > 9) then
               input(j-1:j+1, i-1:i+1) = input(j-1:j+1, i-1:i+1) + 1
               input(j, i) = -huge(1)
            end if
         end do
      end do
   end do

   if (step <= 100) flash = flash + count(input(1:10, 1:10) < 0)
   if (all(input(1:10, 1:10) < 0)) rep = step
   input(1:10, 1:10) = merge(0, input(1:10, 1:10), input(1:10, 1:10) < 0)
end do
print '(a, 1x, i0)', "[1]", flash
print '(a, 1x, i0)', "[2]", rep
end

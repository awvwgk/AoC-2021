implicit none
integer, parameter :: i8 = selected_int_kind(18), max_n = 1000, t0 = 1, t1 = 80, t2 = 256
integer :: input(max_n), io, stat, n, i
character(len=64) :: arg
integer(i8), parameter :: grow(9, 9) = reshape([&
   & 0, 0, 0, 0, 0, 0, 1, 0, 1, &
   & 1, 0, 0, 0, 0, 0, 0, 0, 0, &
   & 0, 1, 0, 0, 0, 0, 0, 0, 0, &
   & 0, 0, 1, 0, 0, 0, 0, 0, 0, &
   & 0, 0, 0, 1, 0, 0, 0, 0, 0, &
   & 0, 0, 0, 0, 1, 0, 0, 0, 0, &
   & 0, 0, 0, 0, 0, 1, 0, 0, 0, &
   & 0, 0, 0, 0, 0, 0, 1, 0, 0, &
   & 0, 0, 0, 0, 0, 0, 0, 1, 0],&
   & shape(grow))
integer(i8) :: pop(9)

pop(:) = 0
input(:) = 0
call get_command_argument(1, arg)
open(newunit=io, file=arg, status='old')
read(io, *, iostat=stat) input
close(io)

n = count(input > 0)
pop(input(:n)) = pop(input(:n)) + 1

do i = t0, t1-1
   pop = matmul(grow, pop)
end do
print '(a, 1x, i0)', "[1]:", sum(pop)

do i = t1, t2-1
   pop = matmul(grow, pop)
end do
print '(a, 1x, i0)', "[2]:", sum(pop)
end

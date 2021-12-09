implicit none
character(len=64) :: arg
character(len=:), allocatable :: line
integer :: io, stat, w, h, i, j, risk, loc, basin(3)
integer, allocatable :: input(:), itmp(:), map(:, :)
logical, allocatable :: done(:, :)

basin = 0
risk = 0
call get_command_argument(1, arg)
open(newunit=io, file=arg, status='old')
call getline(io, line, stat)
w = len(line)
allocate(input(0), itmp(w))
do while(stat == 0)
   read(line, '(*(i1))') itmp
   input = [input, itmp]
   call getline(io, line, stat)
end do
close(io)
h = size(input) / w
allocate(map(0:h+1, 0:w+1), source=9)
allocate(done(0:h+1, 0:w+1), source=.false.)
map(1:h, 1:w) = reshape(input, [w, h])

do i = 1, h
   do j = 1, w
      if (any(map(j,i) >= [map(j-1,i), map(j,i-1), map(j,i+1), map(j+1,i)])) cycle
      risk = risk + map(j, i) + 1
      done(:, :) = .false.
      call color(done, map, j, i)
      loc = count(done)
      if (any(basin < loc)) basin(minloc(basin)) = loc
   end do
end do
print '(a, 1x, i0)', &
   "[1]:", risk, &
   "[2]:", product(basin)

contains

recursive subroutine color(done, map, j, i)
   integer, intent(in) :: map(0:, 0:), i, j
   logical, intent(inout) :: done(0:, 0:)
   done(j, i) = .true.
   if (.not.(done(j-1, i).or.map(j-1, i) == 9)) call color(done, map, j-1, i)
   if (.not.(done(j+1, i).or.map(j+1, i) == 9)) call color(done, map, j+1, i)
   if (.not.(done(j, i-1).or.map(j, i-1) == 9)) call color(done, map, j, i-1)
   if (.not.(done(j, i+1).or.map(j, i+1) == 9)) call color(done, map, j, i+1)
end subroutine color

subroutine getline(unit, line, iostat)
   use, intrinsic :: iso_fortran_env, only : iostat_eor
   integer,intent(in) :: unit
   character(len=:),allocatable,intent(out) :: line
   integer,intent(out),optional :: iostat

   integer,parameter  :: buffersize=144
   character(len=buffersize) :: buffer
   integer :: size
   integer :: err

   line = ''
   do
      read(unit, '(a)', advance='no', iostat=err, size=size) buffer
      if (err > 0) then
         if (present(iostat)) iostat = err
         return ! an error occurred
      end if
      line = line // buffer(:size)
      if (err < 0) then
         if (err == iostat_eor) err = 0
         if (present(iostat)) iostat = err
         return
      end if
   end do

end subroutine getline
end

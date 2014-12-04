using DTW
using Base.Test

# write your own tests here
@test 1 == 1


x=[1:5]
y=[1:2:5]

a = dtw(x,y)
module DTW

function dtw(x,y; distance::Function=Distance.default)
	D = zeros(Float64, length(x)+1, length(y)+1)
	D[1,2:end] = Inf
	D[2:end,1] = Inf
	for i=1:length(x), j=1:length(y)
		D[i+1, j+1] = distance(x[i], y[j])
	end
	for i=1:length(x), j=1:length(y)
		D[i+1, j+1] += min(D[i,j], D[i,j+1], D[i+1,j])
	end

	D = D[2:end, 2:end]
	dist = D[end,end]/sum(size(D))
	dist, D, trackback(D)
end

function trackback(D)
	i,j = size(D)
	p,q = [i],[j]

	while i > 1 && j > 1
		tb = indmin([D[i-1,j-1], D[i-1,j], D[i,j-1]])
		@show(i,j,tb)
		tb in [1,2] && (i-=1)
		tb in [1,3] && (j-=1)
		unshift!(p,i)
		unshift!(q,j)
	end
	unshift!(p,1)
	unshift!(q,1)
	p,q
end

module Distance # contains distance measurement functions
default(x,y) = norm(x-y,1)
end

export dtw

end # module

# Julia translation of http://nbviewer.jupyter.org/github/barbagroup/AeroPython/blob/master/lessons/01_Lesson01_sourceSink.ipynb
# Lession 1 Source and sink

using PyPlot
using Distributions

close("all")
meshgrid(x,y) = (repmat(x',length(y),1),repmat(y,1,length(x)))

N = 40                                # number of points in each direction
x_start, x_end = -2.0, 2.0            # boundaries in the x-direction
y_start, y_end = -1.0, 1.0            # boundaries in the y-direction
x = linspace(x_start, x_end, N)    # creates a 1D-array with the x-coordinates
y = linspace(y_start, y_end, N)    # creates a 1D-array with the y-coordinates

# print("x = ", x)
# print("y = ", y)



X,Y=meshgrid(x,y)
# X = repmat(x',N,1)
# Y= repmat(y,1,N)

# plots the grid of points
size = 10
PyPlot.figure(figsize=(size, (y_end-y_start)/(x_end-x_start)*size))
PyPlot.xlabel('x', fontsize=16)
PyPlot.ylabel('y', fontsize=16)
PyPlot.xlim(x_start, x_end)
PyPlot.ylim(y_start, y_end)
PyPlot.scatter(X, Y)

strength_source = 5.0                      # source strength
x_source, y_source = -1.0, 0.0             # location of the source

# computes the velocity field on the mesh grid

u_source = strength_source/(2*pi) .* (X-x_source)./((X-x_source).^2 + (Y-y_source).^2)
v_source = strength_source/(2*pi) .* (Y-y_source)./((X-x_source).^2 + (Y-y_source).^2)

# plotting the streamlines
size = 10
PyPlot.figure(figsize=(size, (y_end-y_start)/(x_end-x_start)*size))
PyPlot.xlabel('x', fontsize=16)
PyPlot.ylabel('y', fontsize=16)
PyPlot.xlim(x_start, x_end)
PyPlot.ylim(y_start, y_end)
PyPlot.streamplot(X, Y, u_source, v_source, density=2, linewidth=1, arrowsize=2, arrowstyle="->")
PyPlot.scatter(x_source, y_source, color="#CD2305", s=80, marker="o", linewidth=0);

strength_sink = -5.0                     # strength of the sink
x_sink, y_sink = 1.0, 0.0                # location of the sink

# computes the velocity on the mesh grid
u_sink = strength_sink/(2*pi) .* (X-x_sink)./((X-x_sink).^2 + (Y-y_sink).^2)
v_sink = strength_sink/(2*pi) .* (Y-y_sink)./((X-x_sink).^2 + (Y-y_sink).^2)

# plots the streamlines
size = 10
PyPlot.figure(figsize=(size, (y_end-y_start)/(x_end-x_start)*size))
PyPlot.xlabel('x', fontsize=16)
PyPlot.ylabel('y', fontsize=16)
PyPlot.xlim(x_start, x_end)
PyPlot.ylim(y_start, y_end)
PyPlot.streamplot(X, Y, u_sink, v_sink, density=2, linewidth=1, arrowsize=2, arrowstyle="->")
PyPlot.scatter(x_sink, y_sink, color="#CD2305", s=80, marker="o", linewidth=0);

# computes the velocity of the pair source/sink by superposition
u_pair = u_source + u_sink
v_pair = v_source + v_sink

# plots the streamlines of the pair source/sink
size = 10
PyPlot.figure(figsize=(size, (y_end-y_start)/(x_end-x_start)*size))
PyPlot.xlabel('x', fontsize=16)
PyPlot.ylabel('y', fontsize=16)
PyPlot.xlim(x_start, x_end)
PyPlot.ylim(y_start, y_end)
PyPlot.streamplot(X, Y, u_pair, v_pair, density=2.0, linewidth=1, arrowsize=2, arrowstyle="->")
PyPlot.scatter([x_source, x_sink], [y_source, y_sink],
             color="#CD2305", s=80, marker="o", linewidth=0);

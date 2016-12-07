# Julia translation of http://nbviewer.jupyter.org/github/barbagroup/AeroPython/blob/master/lessons/04_Lesson04_vortex.ipynb
# Lesson 3 doublet

using PyPlot
using Distributions

close("all")
meshgrid(x,y) = (repmat(x',length(y),1),repmat(y,1,length(x)))

N = 50                                # number of points in each direction
x_start, x_end = -2.0, 2.0            # boundaries in the x-direction
y_start, y_end = -1.0, 1.0            # boundaries in the y-direction
x = linspace(x_start, x_end, N)    # creates a 1D-array with the x-coordinates
y = linspace(y_start, y_end, N)    # creates a 1D-array with the y-coordinates

X,Y=meshgrid(x,y)

gamma = 5.0

x_vortex, y_vortex = 0.0, 0.0   # location of the source

function get_velocity_vortex(strength, xv, yv, X, Y):
      """Returns the velocity field generated by a vortex.

      Arguments
      ---------
      strength -- strength of the vortex.
      xv, yv -- coordinates of the vortex.
      X, Y -- mesh grid.
      """
      u = + strength/(2*pi).*(Y-yv)./((X-xv).^2+(Y-yv).^2)
      v = - strength/(2*pi).*(X-xv)./((X-xv).^2+(Y-yv).^2)

      return u, v
    end

function get_stream_function_vortex(strength, xv, yv, X, Y):
    """Returns the stream-function generated by a vortex.

    Arguments
    ---------
    strength -- strength of the vortex.
    xv, yv -- coordinates of the vortex.
    X, Y -- mesh grid.
    """
    psi = strength/(4*pi).*log((X-xv).^2+(Y-yv).^2)

    return psi
  end


  # computes the velocity field on the mesh grid
  u_vortex, v_vortex = get_velocity_vortex(gamma, x_vortex, y_vortex, X, Y)

  # computes the stream-function on the mesh grid
  psi_vortex = get_stream_function_vortex(gamma, x_vortex, y_vortex, X, Y)

  # plots the streamlines
  size = 10
  PyPlot.figure(figsize=(size, (y_end-y_start)/(x_end-x_start)*size))
  PyPlot.grid(true)
  PyPlot.xlabel("x", fontsize=16)
  PyPlot.ylabel("y", fontsize=16)
  PyPlot.xlim(x_start, x_end)
  PyPlot.ylim(y_start, y_end)
  PyPlot.streamplot(X, Y, u_vortex, v_vortex, density=2, linewidth=1, arrowsize=1, arrowstyle="->")
  PyPlot.scatter(x_vortex, y_vortex, color="#CD2305", s=80, marker="o")
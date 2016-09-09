# LD3Ditp
3D polynomial interpolation on the nodes of degenerate 3D-Lissajous curves
--------------------------------------------------------------------------------

Copyright (C) 2016 by Peter Dencker and Wolfgang Erb

This package was developed and written by Peter Dencker and Wolfgang Erb 
at the Institute of Mathematics, University of Luebeck.

LD3Ditp is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.


Description
-----------

<img src="img/Lissajous3D.jpg" width="400"> &nbsp;&nbsp;&nbsp; <img src="img/indexset3D.png" width="420">



The package LD3Ditp contains a Matlab-implementation for 3D polynomial interpolation on 
the node points LD of degenerate 3D-Lissajous curves. 

The main test file for interpolation is
main_example.m

For plotting 3D degenerate Lissajous curves and the LD points use
plot_Lissajous3D.m
 

Version: 0.2 (01.07.2016)


Citation and Credits
--------------------

The theory related to this package was developed by P. Dencker and W. Erb in

[1] Dencker, P. and Erb, W., 
    Multivariate polynomial interpolation on Lissajous-Chebyshev nodes,
    arXiv:1511.04564 \[math.NA\] (2016)


The file plotregion.m was written by Per Bergström 2006-01-16. In this package it is used as 
an auxiliary program in plot_Lissajous3D.m to plot the polygonal boundary of the index sets. 

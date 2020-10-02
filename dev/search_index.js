var documenterSearchIndex = {"docs":
[{"location":"analytic/#Analytic-Fields","page":"Analytic Fields","title":"Analytic Fields","text":"","category":"section"},{"location":"analytic/#Arnold-Beltrami-Childress-(ABC)-Field","page":"Analytic Fields","title":"Arnold-Beltrami-Childress (ABC) Field","text":"","category":"section"},{"location":"analytic/","page":"Analytic Fields","title":"Analytic Fields","text":"ABC","category":"page"},{"location":"analytic/#ElectromagneticFields.ABC","page":"Analytic Fields","title":"ElectromagneticFields.ABC","text":"Arnold-Beltrami-Childress (ABC) field in (x,y,z) coordinates with covariant components of the vector potential given by\n\nA (xyz) = big( a  sin(z) + c  cos(y)   b  sin(x) + a  cos(z)   c  sin(y) + b  cos(x) big)^T\n\nresulting in the magnetic field B(xyz) = A(xyz).\n\nParameters: a, b, c\n\n\n\n\n\n","category":"module"},{"location":"analytic/","page":"Analytic Fields","title":"Analytic Fields","text":"using Plots\nusing ElectromagneticFields\n\neq_abc = ElectromagneticFields.ABC.init()\nplot(eq_abc)\nsavefig(\"abc.png\")\n\nnothing","category":"page"},{"location":"analytic/","page":"Analytic Fields","title":"Analytic Fields","text":"Absolut value of the magnetic field:","category":"page"},{"location":"analytic/","page":"Analytic Fields","title":"Analytic Fields","text":"(Image: )","category":"page"},{"location":"analytic/#Axisymmetric-Tokamak-Equilibrium-in-Cartesian-Coordinates","page":"Analytic Fields","title":"Axisymmetric Tokamak Equilibrium in Cartesian Coordinates","text":"","category":"section"},{"location":"analytic/","page":"Analytic Fields","title":"Analytic Fields","text":"AxisymmetricTokamakCartesian","category":"page"},{"location":"analytic/#ElectromagneticFields.AxisymmetricTokamakCartesian","page":"Analytic Fields","title":"ElectromagneticFields.AxisymmetricTokamakCartesian","text":"Axisymmetric tokamak equilibrium in (x,y,z) coordinates with covariant components of the vector potential given by\n\nA (xyz) = frac12 fracB_0q_0  bigg( fracq_0 R_0 x z - r^2 yR^2   fracq_0 R_0 y z + r^2 xR^2   - q_0 R_0  ln bigg( fracRR_0 bigg) bigg)^T \n\nresulting in the magnetic field with covariant components\n\nB (xyz) = fracB_0q_0  bigg( - fracq_0 R_0 y + x zR^2   fracq_0 R_0 x - y zR^2   fracR - R_0R bigg)^T \n\nwhere R = sqrt x^2 + y^2  and r = sqrt (R - R_0)^2 + z^2 .\n\nParameters:\n\nR₀: position of magnetic axis\nB₀: B-field at magnetic axis\nq₀: safety factor at magnetic axis\n\n\n\n\n\n","category":"module"},{"location":"analytic/","page":"Analytic Fields","title":"Analytic Fields","text":"using Plots\nusing ElectromagneticFields\n\neq_car = ElectromagneticFields.AxisymmetricTokamakCartesian.init()\nplot(eq_car)\nsavefig(\"axisymmetric_tokamak_cartesian.png\")\n\nnothing","category":"page"},{"location":"analytic/","page":"Analytic Fields","title":"Analytic Fields","text":"Vector potential in y direction:","category":"page"},{"location":"analytic/","page":"Analytic Fields","title":"Analytic Fields","text":"(Image: )","category":"page"},{"location":"analytic/#Axisymmetric-Tokamak-Equilibrium-in-Cylindrical-Coordinates","page":"Analytic Fields","title":"Axisymmetric Tokamak Equilibrium in Cylindrical Coordinates","text":"","category":"section"},{"location":"analytic/","page":"Analytic Fields","title":"Analytic Fields","text":"AxisymmetricTokamakCylindrical","category":"page"},{"location":"analytic/#ElectromagneticFields.AxisymmetricTokamakCylindrical","page":"Analytic Fields","title":"ElectromagneticFields.AxisymmetricTokamakCylindrical","text":"Axisymmetric tokamak equilibrium in (R,Z,ϕ) coordinates with covariant components of the vector potential given by\n\nA (R Z phi) = fracB_02  bigg( R_0  fracZR   - R_0  ln bigg( fracRR_0 bigg)   - fracr^2q_0 bigg)^T \n\nresulting in the magnetic field with covariant components\n\nB (R Z phi) = fracB_0q_0  bigg( - fracZR   fracR - R_0R   - q_0 R_0 bigg)^T \n\nwhere r = sqrt (R - R_0)^2 + Z^2 .\n\nParameters:\n\nR₀: position of magnetic axis\nB₀: B-field at magnetic axis\nq₀: safety factor at magnetic axis\n\n\n\n\n\n","category":"module"},{"location":"analytic/","page":"Analytic Fields","title":"Analytic Fields","text":"using Plots\nusing ElectromagneticFields\n\neq_cyl = ElectromagneticFields.AxisymmetricTokamakCylindrical.init()\nplot(eq_cyl)\nsavefig(\"axisymmetric_tokamak_cylindrical.png\")\n\nnothing","category":"page"},{"location":"analytic/","page":"Analytic Fields","title":"Analytic Fields","text":"Vector potential in y direction:","category":"page"},{"location":"analytic/","page":"Analytic Fields","title":"Analytic Fields","text":"(Image: )","category":"page"},{"location":"analytic/#Axisymmetric-Tokamak-Equilibrium-in-Toroidal-Coordinates","page":"Analytic Fields","title":"Axisymmetric Tokamak Equilibrium in Toroidal Coordinates","text":"","category":"section"},{"location":"analytic/","page":"Analytic Fields","title":"Analytic Fields","text":"AxisymmetricTokamakToroidal","category":"page"},{"location":"analytic/#ElectromagneticFields.AxisymmetricTokamakToroidal","page":"Analytic Fields","title":"ElectromagneticFields.AxisymmetricTokamakToroidal","text":"Axisymmetric tokamak equilibrium in (r,θ,ϕ) coordinates with covariant components of the vector potential given by\n\nA (r theta phi) = B_0  bigg( 0   fracr R_0cos (theta) - bigg( fracR_0cos (theta) bigg)^2  ln bigg( fracRR_0 bigg)   - fracr^22 q_0 bigg)^T \n\nresulting in the magnetic field with covariant components\n\nB (r theta phi) = fracB_0q_0  bigg( 0   fracr^2R  q_0 R_0 bigg)^T \n\nwhere R = R_0 + r cos theta.\n\nParameters:\n\nR₀: position of magnetic axis\nB₀: B-field at magnetic axis\nq₀: safety factor at magnetic axis\n\n\n\n\n\n","category":"module"},{"location":"analytic/","page":"Analytic Fields","title":"Analytic Fields","text":"using Plots\nusing ElectromagneticFields\n\neq_cir = ElectromagneticFields.AxisymmetricTokamakToroidal.init()\nplot(eq_cir)\nsavefig(\"axisymmetric_tokamak_toroidal.png\")\n\nnothing","category":"page"},{"location":"analytic/","page":"Analytic Fields","title":"Analytic Fields","text":"Vector potential in y direction:","category":"page"},{"location":"analytic/","page":"Analytic Fields","title":"Analytic Fields","text":"(Image: )","category":"page"},{"location":"analytic/#Singular-Magnetic-Field","page":"Analytic Fields","title":"Singular Magnetic Field","text":"","category":"section"},{"location":"analytic/","page":"Analytic Fields","title":"Analytic Fields","text":"Singular","category":"page"},{"location":"analytic/#ElectromagneticFields.Singular","page":"Analytic Fields","title":"ElectromagneticFields.Singular","text":"Singular magnetic field in (x,y,z) coordinates with covariant components of the vector potential given by\n\nA (xyz) = fracB_0sqrt(x^2 + y^2)^3 big( y   - x   0 big)^T\n\nresulting in the magnetic field with covariant components\n\nB(xyz) = B_0  beginpmatrix\n0 \n0 \n(x^2 + y^2)^-32 \nendpmatrix\n\nParameters: B₀\n\n\n\n\n\n","category":"module"},{"location":"analytic/","page":"Analytic Fields","title":"Analytic Fields","text":"using Plots\nusing ElectromagneticFields\n\neq_sng = ElectromagneticFields.Singular.init()\nplot(eq_sng)\nsavefig(\"singular.png\")\n\nnothing","category":"page"},{"location":"analytic/","page":"Analytic Fields","title":"Analytic Fields","text":"Vector potential and magnetic field components:","category":"page"},{"location":"analytic/","page":"Analytic Fields","title":"Analytic Fields","text":"(Image: )","category":"page"},{"location":"analytic/#Symmetric-Magnetic-Field","page":"Analytic Fields","title":"Symmetric Magnetic Field","text":"","category":"section"},{"location":"analytic/","page":"Analytic Fields","title":"Analytic Fields","text":"SymmetricQuadratic","category":"page"},{"location":"analytic/#ElectromagneticFields.SymmetricQuadratic","page":"Analytic Fields","title":"ElectromagneticFields.SymmetricQuadratic","text":"Symmetric quadratic mangetic field in (x,y,z) coordinates with covariant components of the vector potential given by\n\nA (xyz) = fracB_04 big( - y  (2 + x^2 + y^2)   x  (2 + x^2 + y^2)   0 big)^T\n\nresulting in the magnetic field with covariant components\n\nB(xyz) = B_0  beginpmatrix\n0 \n0 \n1 + x^2 + y^2 \nendpmatrix\n\nParameters: B₀\n\n\n\n\n\n","category":"module"},{"location":"analytic/","page":"Analytic Fields","title":"Analytic Fields","text":"using Plots\nusing ElectromagneticFields\n\neq_sym = ElectromagneticFields.SymmetricQuadratic.init()\nplot(eq_sym)\nsavefig(\"symmetric.png\")\n\nnothing","category":"page"},{"location":"analytic/","page":"Analytic Fields","title":"Analytic Fields","text":"Vector potential and magnetic field components:","category":"page"},{"location":"analytic/","page":"Analytic Fields","title":"Analytic Fields","text":"(Image: )","category":"page"},{"location":"analytic/#Symmetric-Solov'ev-Equilibrium","page":"Analytic Fields","title":"Symmetric Solov'ev Equilibrium","text":"","category":"section"},{"location":"analytic/","page":"Analytic Fields","title":"Analytic Fields","text":"SolovevSymmetric","category":"page"},{"location":"analytic/#ElectromagneticFields.SolovevSymmetric","page":"Analytic Fields","title":"ElectromagneticFields.SolovevSymmetric","text":"Symmetric Solov'ev equilibrium in (R,Z,phi) coordinates. Based on McCarthy, Physics of Plasmas 6, 3554, 1999.\n\nParameters:\n\nR₀: position of magnetic axis\nB₀: B-field at magnetic axis\na₀, b₀: free constants\n\n\n\n\n\n","category":"module"},{"location":"analytic/","page":"Analytic Fields","title":"Analytic Fields","text":"using Plots\nusing ElectromagneticFields\n\neq_sol = ElectromagneticFields.SolovevSymmetric.init()\nplot(eq_sol)\nsavefig(\"solovev_symmetric.png\")\n\nnothing","category":"page"},{"location":"analytic/","page":"Analytic Fields","title":"Analytic Fields","text":"Vector potential in z direction:","category":"page"},{"location":"analytic/","page":"Analytic Fields","title":"Analytic Fields","text":"(Image: )","category":"page"},{"location":"analytic/#Solov'ev-Equilibrium","page":"Analytic Fields","title":"Solov'ev Equilibrium","text":"","category":"section"},{"location":"analytic/","page":"Analytic Fields","title":"Analytic Fields","text":"Solovev","category":"page"},{"location":"analytic/#ElectromagneticFields.Solovev","page":"Analytic Fields","title":"ElectromagneticFields.Solovev","text":"Axisymmetric Solov'ev equilibra in (R/R₀,Z/R₀,phi) coordinates. Based on Cerfon & Freidberg, Physics of Plasmas 17, 032502, 2010.\n\nParameters:\n\nR₀: position of magnetic axis\nB₀: B-field at magnetic axis\nϵ:  inverse aspect ratio\nκ:  elongation\nδ:  triangularity\na:  free constant, determined to match a given beta value\n\n\n\n\n\n","category":"module"},{"location":"analytic/","page":"Analytic Fields","title":"Analytic Fields","text":"using Plots\nusing ElectromagneticFields\n\neq_sol_iter = ElectromagneticFields.Solovev.ITER()\nplot_iter = plot(eq_sol_iter, title=\"ITER\", xlims=(0.6,1.4))\n\neq_sol_nstx = ElectromagneticFields.Solovev.NSTX()\nplot_nstx = plot(eq_sol_nstx, title=\"NSTX\", xlims=(0.05, 2.3), ylims=(-2.25, +2.25), levels=50)\n\neq_sol_frc = ElectromagneticFields.Solovev.FRC()\nplot_frc = plot(eq_sol_frc, title=\"FRC\", xlims=(0,2), ylims=(-10,+10), levels=25, aspect_ratio=1//5)\n\nplot(size=(800,400), layout=(1,3), plot_iter, plot_nstx, plot_frc)\nsavefig(\"solovev.png\")\n\nnothing","category":"page"},{"location":"analytic/","page":"Analytic Fields","title":"Analytic Fields","text":"Vector potential in ITER, NSTX and a field reversed configuration:","category":"page"},{"location":"analytic/","page":"Analytic Fields","title":"Analytic Fields","text":"(Image: )","category":"page"},{"location":"analytic/#Solov'ev-Equilibrium-with-X-Point","page":"Analytic Fields","title":"Solov'ev Equilibrium with X-Point","text":"","category":"section"},{"location":"analytic/","page":"Analytic Fields","title":"Analytic Fields","text":"SolovevXpoint","category":"page"},{"location":"analytic/#ElectromagneticFields.SolovevXpoint","page":"Analytic Fields","title":"ElectromagneticFields.SolovevXpoint","text":"Axisymmetric Solov'ev equilibra with X-point in (R/R₀,Z/R₀,phi) coordinates. Based on Cerfon & Freidberg, Physics of Plasmas 17, 032502, 2010.\n\nParameters:\n\nR₀: position of magnetic axis\nB₀: B-field at magnetic axis\nϵ:  inverse aspect ratio\nκ:  elongation\nδ:  triangularity\na:  free constant, determined to match a given beta value\nxsep: x position of the X point\nysep: y position of the X point\n\n\n\n\n\n","category":"module"},{"location":"analytic/","page":"Analytic Fields","title":"Analytic Fields","text":"using Plots\nusing ElectromagneticFields\n\neq_sol_iter = ElectromagneticFields.SolovevXpoint.ITER()\nplot_iter = plot(eq_sol_iter, title=\"ITER\", xlims=(0.6,1.4))\n\neq_sol_nstx = ElectromagneticFields.SolovevXpoint.NSTX()\nplot_nstx = plot(eq_sol_nstx, title=\"NSTX\", xlims=(0.05, 2.3), ylims=(-2.25, +2.25), levels=50)\n\nplot(size=(600,400), plot_iter, plot_nstx)\nsavefig(\"solovev_xpoint.png\")\n\nnothing","category":"page"},{"location":"analytic/","page":"Analytic Fields","title":"Analytic Fields","text":"Vector potential in ITER and NSTX:","category":"page"},{"location":"analytic/","page":"Analytic Fields","title":"Analytic Fields","text":"(Image: )","category":"page"},{"location":"analytic/#Theta-Pinch","page":"Analytic Fields","title":"Theta Pinch","text":"","category":"section"},{"location":"analytic/","page":"Analytic Fields","title":"Analytic Fields","text":"ThetaPinch","category":"page"},{"location":"analytic/#ElectromagneticFields.ThetaPinch","page":"Analytic Fields","title":"ElectromagneticFields.ThetaPinch","text":"θ-pinch equilibrium in (x,y,z) coordinates with covariant components of the vector potential given by\n\nA (xyz) = fracB_02 big( - y   x   0 big)^T\n\nresulting in the magnetic field with covariant components\n\nB (xyz) = big( 0   0   B_0 big)^T \n\nParameters:     B₀: B-field at magnetic axis\n\n\n\n\n\n","category":"module"},{"location":"analytic/","page":"Analytic Fields","title":"Analytic Fields","text":"using Plots\nusing ElectromagneticFields\n\neq_thp = ElectromagneticFields.ThetaPinch.init()\nplot(eq_thp)\nsavefig(\"theta_pinch.png\")\n\nnothing","category":"page"},{"location":"analytic/","page":"Analytic Fields","title":"Analytic Fields","text":"Vector potential components:","category":"page"},{"location":"analytic/","page":"Analytic Fields","title":"Analytic Fields","text":"(Image: )","category":"page"},{"location":"#ElectromagneticFields.jl","page":"Home","title":"ElectromagneticFields.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Common Interface for Electromagnetic Fields","category":"page"},{"location":"#References","page":"Home","title":"References","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Antoine J. Cerfon, Jeffrey P. Freidberg. \"One size fits all\" analytic solutions to the Grad–Shafranov equation. Physics of Plasmas 17 (3), 032502.","category":"page"},{"location":"#License","page":"Home","title":"License","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Copyright (c) Michael Kraus <michael.kraus@ipp.mpg.de>Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.","category":"page"},{"location":"modules/#ElectromagneticFields.jl-–-Modules","page":"Modules","title":"ElectromagneticFields.jl – Modules","text":"","category":"section"},{"location":"modules/","page":"Modules","title":"Modules","text":"Modules = [ElectromagneticFields]\nOrder   = [:constant, :type, :macro, :function]","category":"page"},{"location":"modules/#ElectromagneticFields.connection-NTuple{6,Any}","page":"Modules","title":"ElectromagneticFields.connection","text":"Returns the l-th component of the Levi-Civita connection\n\n\n\n\n\n","category":"method"},{"location":"modules/#ElectromagneticFields.crossproduct-NTuple{5,Any}","page":"Modules","title":"ElectromagneticFields.crossproduct","text":"Returns the m-th component of the cross-product between the vectors v and w\n\n\n\n\n\n","category":"method"},{"location":"modules/#ElectromagneticFields.generate_equilibrium_code","page":"Modules","title":"ElectromagneticFields.generate_equilibrium_code","text":"Generate code for evaluating analytic equilibria.\n\n\n\n\n\n","category":"function"},{"location":"modules/#ElectromagneticFields.generate_equilibrium_functions-Tuple{AnalyticEquilibrium,AnalyticPerturbation}","page":"Modules","title":"ElectromagneticFields.generate_equilibrium_functions","text":"Generate functions for evaluating analytic equilibria.\n\n\n\n\n\n","category":"method"},{"location":"modules/#ElectromagneticFields.get_oneform_component-Tuple{Any,Any,Any}","page":"Modules","title":"ElectromagneticFields.get_oneform_component","text":"Returns the i-th component of the one-form corresponding to the vector v\n\n\n\n\n\n","category":"method"},{"location":"modules/#ElectromagneticFields.get_vector_component-Tuple{Any,Any,Any}","page":"Modules","title":"ElectromagneticFields.get_vector_component","text":"Returns the i-th component of the vector corresponding to the one-form α\n\n\n\n\n\n","category":"method"},{"location":"modules/#ElectromagneticFields.hodge²¹-NTuple{4,Any}","page":"Modules","title":"ElectromagneticFields.hodge²¹","text":"Returns the m-th component of the one-form corresponding to the two-form β\n\n\n\n\n\n","category":"method"},{"location":"modules/#ElectromagneticFields.load_equilibrium","page":"Modules","title":"ElectromagneticFields.load_equilibrium","text":"Evaluate functions for evaluating analytic equilibria.\n\n\n\n\n\n","category":"function"},{"location":"modules/#ElectromagneticFields.magnitude-Tuple{Any,Any}","page":"Modules","title":"ElectromagneticFields.magnitude","text":"Returns the length of the vector v\n\n\n\n\n\n","category":"method"},{"location":"modules/#ElectromagneticFields.normalize-Tuple{Any,Any}","page":"Modules","title":"ElectromagneticFields.normalize","text":"Normalises the vector v in the metric g\n\n\n\n\n\n","category":"method"},{"location":"modules/#ElectromagneticFields.Γ-NTuple{6,Any}","page":"Modules","title":"ElectromagneticFields.Γ","text":"Returns the Christoffel symbol Γⱼₖˡ\n\n\n\n\n\n","category":"method"}]
}

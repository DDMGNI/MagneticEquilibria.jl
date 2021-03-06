@doc raw"""
Symmetric quadratic mangetic field in (x,y,z) coordinates with covariant components of
the vector potential given by
```math
A (x,y,z) = \frac{B_0}{4} \big( - y \, (2 + x^2 + y^2) , \, x \, (2 + x^2 + y^2) , \, 0 \big)^T
```
resulting in the magnetic field with covariant components
```math
B(x,y,z) = B_0 \, \begin{pmatrix}
0 \\
0 \\
1 + x^2 + y^2 \\
\end{pmatrix}
```

Parameters: `B₀`
"""
module SymmetricQuadratic

    using RecipesBase
    using LaTeXStrings

    import ..ElectromagneticFields
    import ..ElectromagneticFields: CartesianEquilibrium, code
    import ..ElectromagneticFields: A₁, A₂, A₃
    import ..AnalyticCartesianField: X, Y, Z

    export SymmetricQuadraticEquilibrium

    const DEFAULT_B₀ = 1.0

    struct SymmetricQuadraticEquilibrium{T <: Number} <: CartesianEquilibrium
        name::String
        B₀::T
        SymmetricQuadraticEquilibrium{T}(B₀::T) where T <: Number = new("Symmetric Quadratic Magnetic Field", B₀)
    end

    SymmetricQuadraticEquilibrium(B₀::T=DEFAULT_B₀) where T <: Number = SymmetricQuadraticEquilibrium{T}(B₀)

    function init(B₀=DEFAULT_B₀)
        SymmetricQuadraticEquilibrium(B₀)
    end

    macro code(B₀=DEFAULT_B₀)
        code(init(B₀); escape=true)
    end


    function Base.show(io::IO, equ::SymmetricQuadraticEquilibrium)
        print(io, equ.name)
    end


    r²(x::AbstractVector, equ::SymmetricQuadraticEquilibrium) = X(x,equ)^2 + Y(x,equ)^2
    r(x::AbstractVector, equ::SymmetricQuadraticEquilibrium) = sqrt(r²(x,equ))
    R(x::AbstractVector, equ::SymmetricQuadraticEquilibrium) = r(x,equ)
    θ(x::AbstractVector, equ::SymmetricQuadraticEquilibrium) = atan(Y(x,equ), X(x,equ))
    ϕ(x::AbstractVector, equ::SymmetricQuadraticEquilibrium) = θ(x,equ)

    ElectromagneticFields.A₁(x::AbstractVector, equ::SymmetricQuadraticEquilibrium) = - equ.B₀ * x[2] * (2 + x[1]^2 + x[2]^2) / 4
    ElectromagneticFields.A₂(x::AbstractVector, equ::SymmetricQuadraticEquilibrium) = + equ.B₀ * x[1] * (2 + x[1]^2 + x[2]^2) / 4
    ElectromagneticFields.A₃(x::AbstractVector, equ::SymmetricQuadraticEquilibrium) = zero(eltype(x))
    B(x::AbstractVector, equ::SymmetricQuadraticEquilibrium) = equ.B₀ / (1 + x[1]^2 + x[2]^2)

    ElectromagneticFields.get_functions(::SymmetricQuadraticEquilibrium) = (X=X, Y=Y, Z=Z, R=R, r=r, θ=θ, ϕ=ϕ, r²=r²)


    @recipe function f(equ::SymmetricQuadraticEquilibrium;
                       nx = 100, ny = 100, levels = 20, size = (400,1200),
                       xlims = (-1., +1.),
                       ylims = (-1., +1.))

        xgrid  = LinRange(xlims[1], xlims[2], nx)
        ygrid  = LinRange(ylims[1], ylims[2], ny)
        pot1   = [A₁([xgrid[i], ygrid[j], 0], equ) for i in eachindex(xgrid), j in eachindex(ygrid)]
        pot2   = [A₂([xgrid[i], ygrid[j], 0], equ) for i in eachindex(xgrid), j in eachindex(ygrid)]
        Bfield = [B([xgrid[i], ygrid[j], 0], equ) for i in eachindex(xgrid), j in eachindex(ygrid)]

        seriestype   := :contour
        aspect_ratio := :equal
        layout := (3,1)
        size   := size
        xlims  := xlims
        ylims  := ylims
        levels := levels
        legend := :none

        @series begin
            subplot := 1
            title  := L"A_x (x,y)"
            xguide := L"x"
            yguide := L"y"
            (xgrid, ygrid, pot1)
        end

        @series begin
            subplot := 2
            title  := L"A_y (x,y)"
            xguide := L"x"
            yguide := L"y"
            (xgrid, ygrid, pot2)
        end

        @series begin
            subplot := 3
            title  := L"B_z (x,y)"
            xguide := L"x"
            yguide := L"y"
            (xgrid, ygrid, Bfield)
        end
    end

end

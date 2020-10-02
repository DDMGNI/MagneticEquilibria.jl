
using Combinatorics
using SymEngine

abstract type AnalyticField <: ElectromagneticField end
abstract type AnalyticEquilibrium <: AnalyticField end
abstract type AnalyticPerturbation <: AnalyticField end

get_functions(::AnalyticField) = NamedTuple()

x¹(::AbstractVector, ::ET) where {ET <: AnalyticField} = error("x¹() not implemented for ", ET)
x²(::AbstractVector, ::ET) where {ET <: AnalyticField} = error("x²() not implemented for ", ET)
x³(::AbstractVector, ::ET) where {ET <: AnalyticField} = error("x³() not implemented for ", ET)

ξ¹(::AbstractVector, ::ET) where {ET <: AnalyticField} = error("ξ¹() not implemented for ", ET)
ξ²(::AbstractVector, ::ET) where {ET <: AnalyticField} = error("ξ²() not implemented for ", ET)
ξ³(::AbstractVector, ::ET) where {ET <: AnalyticField} = error("ξ³() not implemented for ", ET)

J(::AbstractVector, ::ET) where {ET <: AnalyticField} = error("J() not implemented for ", ET)

g₁₁(::AbstractVector{T}, ::AnalyticField) where {T} = one(T)
g₁₂(::AbstractVector{T}, ::AnalyticField) where {T} = zero(T)
g₁₃(::AbstractVector{T}, ::AnalyticField) where {T} = zero(T)
g₂₁(::AbstractVector{T}, ::AnalyticField) where {T} = zero(T)
g₂₂(::AbstractVector{T}, ::AnalyticField) where {T} = one(T)
g₂₃(::AbstractVector{T}, ::AnalyticField) where {T} = zero(T)
g₃₁(::AbstractVector{T}, ::AnalyticField) where {T} = zero(T)
g₃₂(::AbstractVector{T}, ::AnalyticField) where {T} = zero(T)
g₃₃(::AbstractVector{T}, ::AnalyticField) where {T} = one(T)

periodicity(x::AbstractVector, ::AnalyticField) = zero(x)

from_cartesian(x::AbstractVector, equ::AnalyticField) = [ξ¹(x,equ), ξ²(x,equ), ξ³(x,equ)]
to_cartesian(ξ::AbstractVector, equ::AnalyticField) = [x¹(ξ,equ), x²(ξ,equ), x³(ξ,equ)]

A₁(::AbstractVector, ::ET) where {ET <: AnalyticField} = error("A₁() not implemented for ", ET)
A₂(::AbstractVector, ::ET) where {ET <: AnalyticField} = error("A₂() not implemented for ", ET)
A₃(::AbstractVector, ::ET) where {ET <: AnalyticField} = error("A₃() not implemented for ", ET)

φ(::AbstractVector{T}, ::AnalyticField) where {T} = zero(T)

function A(x, equ)
    [A₁(x,equ), A₂(x,equ), A₃(x,equ)]
end

function g(x, equ)
    [g₁₁(x,equ)  g₁₂(x,equ)  g₁₃(x,equ);
     g₂₁(x,equ)  g₂₂(x,equ)  g₂₃(x,equ);
     g₃₁(x,equ)  g₃₂(x,equ)  g₃₃(x,equ);]
end


struct ZeroPerturbation <: AnalyticPerturbation
    name::String
    ZeroPerturbation() = new("ZeroPerturbation")
end

A₁(::AbstractVector{T}, ::AnalyticPerturbation) where {T} = zero(T)
A₂(::AbstractVector{T}, ::AnalyticPerturbation) where {T} = zero(T)
A₃(::AbstractVector{T}, ::AnalyticPerturbation) where {T} = zero(T)


"Returns the i-th component of the vector corresponding to the one-form α"
function get_vector_component(α, g̅, i)
    g̅[i,1] * α[1] + g̅[i,2] * α[2] + g̅[i,3] * α[3]
end

"Returns the i-th component of the one-form corresponding to the vector v"
function get_oneform_component(v, g, i)
    g[i,1] * v[1] + g[i,2] * v[2] + g[i,3] * v[3]
end

"Returns the m-th component of the one-form corresponding to the two-form β"
function hodge²¹(β, g̅, J, m)
    α = 0

    for i in 1:3
        for j in 1:3
            for k in 1:3
                for l in 1:3
                    α += β[i,j] * g̅[i,k] * g̅[j,l] * levicivita([k,l,m])
                end
            end
        end
    end

    return J*α
end

"Returns the Christoffel symbol Γⱼₖˡ"
function Γ(g, g̅, x, j, k, l)
    γ = Basic(0)
    for r in 1:3
        γ += g̅[l,r] * diff(g[r,j], x[k])
        γ += g̅[l,r] * diff(g[r,k], x[j])
        γ -= g̅[l,r] * diff(g[j,k], x[r])
    end
    return γ / 2
end


"Returns the l-th component of the Levi-Civita connection"
function connection(u, v, x, g, g̅, l)
    w = Basic(0)
    for j in 1:3
        for k in 1:3
            w += u[j] * ( diff(v[l], x[j]) + v[k] * Γ(g, g̅, x, j, k, l) )
        end
    end
    return w
end

"Returns the m-th component of the cross-product between the vectors v and w"
function crossproduct(v, w, g̅, J, l)
    u = zero(J)

    for i in 1:3
        for j in 1:3
            for k in 1:3
                u += v[i] * w[j] * g̅[k,l] * levicivita([i,j,k])
            end
        end
    end

    return J*u
end

"Returns the length of the vector v"
function magnitude(v, g)
    l = Basic(0)

    for i in 1:3
        for j in 1:3
            l += v[i] * g[i,j] * v[j]
        end
    end

    return sqrt(l)
end

"Normalises the vector v in the metric g"
function normalize(v, g)
    return v ./ magnitude(v, g)
end
    

"""
Generate functions for evaluating analytic equilibria.
"""
function generate_equilibrium_functions(equ::AnalyticEquilibrium, pert::AnalyticPerturbation; output=0)
    # define symbols for time t and coordinates x = (x₁, x₂, x₃),
    # positive=true is set so that sqrt(x^2) does not become |x^2|
    t, x₁, x₂, x₃, ξ₁, ξ₂, ξ₃ = symbols("t, x₁, x₂, x₃, ξ₁, ξ₂, ξ₃")#, real=true, positive=true)
    x = [x₁, x₂, x₃]
    ξ = [ξ₁, ξ₂, ξ₃]
    symprint("x", x, output, 2)
    symprint("ξ", ξ, output, 2)

    # check for compatible metric
    if typeof(pert) != ZeroPerturbation
        @assert J(x,equ) == J(x,pert)
        @assert g(x,equ) == g(x,pert)
    end

    # cartesian coordinates
    x̂ = [x¹(x, equ), x²(x, equ), x³(x, equ)]

    # curvilinear coordinates
    ξ̂ = [ξ¹(x, equ), ξ²(x, equ), ξ³(x, equ)]

    # Jacobian
    DF = [diff(x̂[i], x[j]) for i in 1:3, j in 1:3]
    symprint("DF", DF, output, 2)

    DF̄ = [diff(ξ̂[i], x[j]) for i in 1:3, j in 1:3]
    symprint("DF̄", DF̄, output, 2)

    # obtain metric
    gmat = g(x, equ)
    symprint("g", gmat, output, 2)

    # invert metric
    ginv = inv(gmat)
    symprint("g⁻¹", ginv, output, 2)

    # derivatives of metric coefficients
    Dg = [diff(gmat[i,j], x[k]) for i in 1:3, j in 1:3, k in 1:3]
    symprint("Dg", Dg, output, 3)

    # compute Jacobian determinant
    # Jdet² = expand(det(gmat))
    # symprint("J²", Jdet², output, 2)

    # Jdet = sqrt(Jdet²)
    Jdet = J(x, equ)
    symprint("J", Jdet, output, 2)

    # obtain vector potential
    A¹ = A(x, equ) .+ A(x, pert)
    symprint("A¹", A¹, output, 2)

    # compute vector potential in contravariant coordinates
    Avec = [get_vector_component(A¹, ginv, i) for i in 1:3]
    symprint("Avec", Avec, output, 2)

    # compute Jacobian of vector potential A
    DA = [(diff(A¹[i], x[j])) for i in 1:3, j in 1:3]
    symprint("DA", DA, output, 3)

    # compute second derivative of vector potential A
    DDA1 = [diff(diff(A¹[1], x[i]), x[j]) for i in 1:3, j in 1:3]
    symprint("DDA1", DDA1, output, 3)

    DDA2 = [diff(diff(A¹[2], x[i]), x[j]) for i in 1:3, j in 1:3]
    symprint("DDA2", DDA2, output, 3)

    DDA3 = [diff(diff(A¹[3], x[i]), x[j]) for i in 1:3, j in 1:3]
    symprint("DDA3", DDA3, output, 3)

    # compute components of magnetic field B
    Bᶜ = [diff(A¹[3], x[2]) - diff(A¹[2], x[3]),
          diff(A¹[1], x[3]) - diff(A¹[3], x[1]),
          diff(A¹[2], x[1]) - diff(A¹[1], x[2])]
    symprint("Bᶜ", Bᶜ, output, 2)

    # compute magnetic field two-form B²
    B² = [ 0      +Bᶜ[3]    -Bᶜ[2];
          -Bᶜ[3]   0        +Bᶜ[1];
          +Bᶜ[2]   -Bᶜ[1]    0    ] .* Rational(1,2)
    symprint("B²", B², output, 2)

    # compute magnetic field one-form B¹ = ⋆B²
    B¹ = [hodge²¹(B², ginv, Jdet, i) for i in 1:3]
    symprint("B¹", B¹, output, 2)

    # compute magnetic field in contravariant coordinates
    Bvec = [get_vector_component(B¹, ginv, i) for i in 1:3]
    symprint("Bvec", Bvec, output, 2)

    # compute absolute value |B| of B
    Babs = sqrt(transpose(Bvec) * B¹)
    symprint("|B|", Babs, output, 2)

    # compute magnetic unit one-form
    b¹ = [B¹[i] / Babs for i in 1:3]
    symprint("b¹", b¹, output, 2)

    # compute unit magnetic field in contravariant coordinates
    bvec = [Bvec[i] / Babs for i in 1:3]
    symprint("bvec", bvec, output, 2)

    # compute Jacobian of magnetic field B
    DB = [diff(B¹[i], x[j]) for i in 1:3, j in 1:3]
    symprint("DB", DB, output, 3)

    # compute Jacobian of magnetic unit oneform b
    Db = [diff(b¹[i], x[j]) for i in 1:3, j in 1:3]
    symprint("Db", Db, output, 3)

    # compute Jacobian of magnetic unit vector b
    Db⃗ = [diff(bvec[i], x[j]) for i in 1:3, j in 1:3]
    symprint("Db⃗", Db⃗, output, 3)

    # compute second derivative of magnetic unit vector b
    DDb1 = [diff(diff(b¹[1], x[i]), x[j]) for i in 1:3, j in 1:3]
    symprint("DDb1", DDb1, output, 3)

    DDb2 = [diff(diff(b¹[2], x[i]), x[j]) for i in 1:3, j in 1:3]
    symprint("DDb2", DDb2, output, 3)

    DDb3 = [diff(diff(b¹[3], x[i]), x[j]) for i in 1:3, j in 1:3]
    symprint("DDb3", DDb3, output, 3)

    # compute first derivatives of absolute value of magnetic field
    DBabs = [diff(Babs, x[j]) for j in 1:3]
    symprint("D|B|", DBabs, output, 3)

    # compute second derivatives of absolute value of magnetic field
    DDBabs = [diff(diff(Babs, x[i]), x[j]) for i in 1:3, j in 1:3]
    symprint("DD|B|", DDBabs, output, 3)

    # compute unit vectors perpendicular to magnetic field
    dbᶜ = [diff(b¹[3], x[2]) - diff(b¹[2], x[3]),
           diff(b¹[1], x[3]) - diff(b¹[3], x[1]),
           diff(b¹[2], x[1]) - diff(b¹[1], x[2])]
    db² = [ 0         +dbᶜ[3]    -dbᶜ[2];
            -dbᶜ[3]   0          +dbᶜ[1];
            +dbᶜ[2]   -dbᶜ[1]    0    ] .* Rational(1,2)
    db¹ = [hodge²¹(db², ginv, Jdet, i) for i in 1:3]
    dbvec = [get_vector_component(db¹, ginv, i) for i in 1:3]
    Avec = [crossproduct(dbvec, bvec, ginv, Jdet, i) for i in 1:3]

    # Avec = [connection(bvec, bvec, x, gmat, ginv, i) for i in 1:3]

    Amag = magnitude(Avec, gmat)
    if Amag != 0
        avec = Avec ./ Amag
    else
        if bvec[1] == 0
            avec = [Basic(1), Basic(0), Basic(0)]
        elseif bvec[2] == 0
            avec = [Basic(0), Basic(1), Basic(0)]
        elseif bvec[3] == 0
            avec = [Basic(0), Basic(0), Basic(1)]
        else
            avec = normalize([crossproduct(bvec, [1, 0, 0], ginv, Jdet, i) for i in 1:3], gmat)
        end
    end
    cvec = normalize([crossproduct(bvec, avec, ginv, Jdet, i) for i in 1:3], gmat)

    # obtain scalar potential
    φ⁰ = φ(x, equ) .+ φ(x, pert)

    # compute components of electric field E
    E¹ = [diff(-φ⁰, x[1]),
          diff(-φ⁰, x[2]),
          diff(-φ⁰, x[3])]
    symprint("E¹", E¹, output, 2)

    # compute electric field in contravariant coordinates
    Evec = [get_vector_component(E¹, ginv, i) for i in 1:3]
    symprint("Evec", Evec, output, 2)

    # collect all functions to generate code for
    functions = Dict{String,Any}()
    indices   = ["₁", "₂", "₃"]
    indicesup = ["¹", "²", "³"]

    for f in pairs(get_functions(equ))
        functions[string(f[1])] = f[2](x, equ)
    end

    # cartesian coordinates
    functions["x¹"] = x̂[1]
    functions["x²"] = x̂[2]
    functions["x³"] = x̂[3]

    # curvilinear coordinates
    functions["ξ¹"] = ξ̂[1]
    functions["ξ²"] = ξ̂[2]
    functions["ξ³"] = ξ̂[3]

    # coordinate conversion functions
    functions["to_cartesian"] = to_cartesian(x, equ)
    functions["from_cartesian"] = from_cartesian(x, equ)

    functions["J"] = Jdet
    functions["B"] = Babs
    functions["φ"] = φ⁰

    for i in 1:3
        functions["A" * indices[i]] = A¹[i]
        functions["B" * indices[i]] = B¹[i]
        functions["b" * indices[i]] = b¹[i]
        functions["E" * indices[i]] = E¹[i]

        functions["A" * indicesup[i]] = Avec[i]
        functions["B" * indicesup[i]] = Bvec[i]
        functions["a" * indicesup[i]] = avec[i]
        functions["b" * indicesup[i]] = bvec[i]
        functions["c" * indicesup[i]] = cvec[i]
        functions["E" * indicesup[i]] = Evec[i]

        functions["dBdx" * indices[i]] = DBabs[i]
    end

    for i in 1:3
        for j in 1:3
            functions["g"  * indices[i]   * indices[j]]   = gmat[i,j]
            functions["g"  * indicesup[i] * indicesup[j]] = ginv[i,j]

            functions["DF" * indices[i]   * indices[j]]   = DF[i,j]
            functions["DF̄" * indices[i]   * indices[j]]   = DF̄[i,j]

            functions["B"  * indices[i]   * indices[j]]   = B²[i,j]

            functions["dA" * indices[i]   * "dx" * indices[j]] = DA[i,j]
            functions["dB" * indices[i]   * "dx" * indices[j]] = DB[i,j]
            functions["db" * indices[i]   * "dx" * indices[j]] = Db[i,j]
            functions["db⃗" * indicesup[i] * "dx" * indices[j]] = Db⃗[i,j]

            functions["d²A₁" * "dx" * indices[i] * "dx" * indices[j]] = DDA1[i,j]
            functions["d²A₂" * "dx" * indices[i] * "dx" * indices[j]] = DDA2[i,j]
            functions["d²A₃" * "dx" * indices[i] * "dx" * indices[j]] = DDA3[i,j]
            functions["d²b₁" * "dx" * indices[i] * "dx" * indices[j]] = DDb1[i,j]
            functions["d²b₂" * "dx" * indices[i] * "dx" * indices[j]] = DDb2[i,j]
            functions["d²b₃" * "dx" * indices[i] * "dx" * indices[j]] = DDb3[i,j]
            functions["d²B"  * "dx" * indices[i] * "dx" * indices[j]] = DDBabs[i,j]
        end
    end

    for i in 1:3
        for j in 1:3
            for k in 1:3
                functions["dg" * indices[i] * indices[j] * "dx" * indices[k]] = Dg[i,j,k]
            end
        end
    end

    t, (x₁, x₂, x₃), functions
end


function replace_expr!(e, old, new)
    for (i,a) in enumerate(e.args)
        if a==old
            e.args[i] = new
        elseif a isa Expr
            replace_expr!(a, old, new)
        end
    end
    e
end


"""
Generate code for evaluating analytic equilibria.
"""
function generate_equilibrium_code(equ, pert=ZeroPerturbation(); output=0)

    if output ≥ 1
        println("Generating code for ")
        println(equ)
        if typeof(pert) != ZeroPerturbation
            println("   and ")
            println(pert)
        end
        println()
    end

    parameters = fieldnames(typeof(equ))
    t, x, functions = generate_equilibrium_functions(equ, pert; output=output)

    equ_code = :(  )

    # generate Julia code and export parameters
    for param in parameters
        if param != :name
            value = getfield(equ, param)

            p_code = quote
                export $param
                $param = $value
            end

            # append p_code to equ_code
            push!(equ_code.args, p_code)
        end
    end

    # generate Julia code and export functions
    for (key, value) in functions
        f_symb = Symbol(key)
        f_expr = value

        output ≥ 1 ? println("Generating function ", key) : nothing

        f_body = convert(Expr, f_expr)
        replace_expr!(f_body, :atan2, :atan)
        output ≥ 2 ? println("   ", f_body) : nothing

        f_code = quote
            export $f_symb
            @inline function $f_symb(t, x₁, x₂, x₃)
                $f_body
            end
            @inline function $f_symb(t::Number, x::AbstractArray{T,1}) where {T <: Number}
                $f_symb(t,x[1],x[2],x[3])
            end
        end

        # append f_code to equ_code
        push!(equ_code.args, f_code)
    end

    # generate Julia code and export special functions
    f_code = quote
        export b, a⃗, b⃗, c⃗, g, ḡ, DF, DF̄
        b(t,x) = [b₁(t,x), b₂(t,x), b₃(t,x)]

        a⃗(t,x) = [a¹(t,x), a²(t,x), a³(t,x)]
        b⃗(t,x) = [b¹(t,x), b²(t,x), b³(t,x)]
        c⃗(t,x) = [c¹(t,x), c²(t,x), c³(t,x)]
        
        function DF(t, x)
            [DF₁₁(t,x)  DF₁₂(t,x)  DF₁₃(t,x);
             DF₂₁(t,x)  DF₂₂(t,x)  DF₂₃(t,x);
             DF₃₁(t,x)  DF₃₂(t,x)  DF₃₃(t,x);]
        end

        function DF̄(t, x)
            [DF̄₁₁(t,x)  DF̄₁₂(t,x)  DF̄₁₃(t,x);
             DF̄₂₁(t,x)  DF̄₂₂(t,x)  DF̄₂₃(t,x);
             DF̄₃₁(t,x)  DF̄₃₂(t,x)  DF̄₃₃(t,x);]
        end

        function g(t, x)
            [g₁₁(t,x)  g₁₂(t,x)  g₁₃(t,x);
             g₂₁(t,x)  g₂₂(t,x)  g₂₃(t,x);
             g₃₁(t,x)  g₃₂(t,x)  g₃₃(t,x);]
        end        

        function ḡ(t, x)
            [g¹¹(t,x)  g¹²(t,x)  g¹³(t,x);
             g²¹(t,x)  g²²(t,x)  g²³(t,x);
             g³¹(t,x)  g³²(t,x)  g³³(t,x);]
        end        
    end

    # append f_code to equ_code
    push!(equ_code.args, f_code)

    output ≥ 1 ? println() : nothing

    return equ_code
end


"""
Evaluate functions for evaluating analytic equilibria.
"""
function load_equilibrium(equ, pert=ZeroPerturbation(); target_module=Main, output=0)
    equ_code = generate_equilibrium_code(equ, pert; output=output)
    Core.eval(target_module, equ_code)
end


function symprint(name, symexpr, output=1, detail_level=0)
    if output ≥ detail_level
        println(name, " = ", symexpr, "\n")
    end
end

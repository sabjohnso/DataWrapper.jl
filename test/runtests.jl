### file: DataWrapper/src/DataWrapper.jl

## Copyright (c) 2015 Samuel B. Johnson

## Author: Samuel B. Johnson <sabjohnso@yahoo.com>

## This file is lincesed under a two license system. For commercial use
## that is not compatible with the GPLv3, please contact the author.
## Otherwise, continue reading below.

## This file is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3, or (at your option)
## any later version.

## You should have received a copy of the GNU General Public License
## along with this program. If not, see <http://www.gnu.org/licenses/>.

### Code:

using DataWrapper
using FactCheck


import Base.==

import DataWrapper.data
import DataWrapper.unit


type ArrayWrapper{ T, n } <: AbstractDataWrapper
    data::Array{T,n}
end

unit{ T, n }( ::Type{ArrayWrapper{T,n}} ) = x -> ArrayWrapper( x )
==( x::ArrayWrapper, y::ArrayWrapper) = map( ==, x, y )


facts( "Data Wrapper" ) do

    a = ArrayWrapper( [1.0, 2.0] )

    @fact isa( a, ArrayWrapper{ Float64, 1 }) --> true
    @fact typeof( a ) <: AbstractDataWrapper --> true
    @fact reduce( &,  map( x -> x*x, a ) == ArrayWrapper( [1.0, 4.0] )) --> true
    
end

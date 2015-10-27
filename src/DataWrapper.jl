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

"
module DataWrapper
------------------
A module to help build functionality for types that wrap
collections.
"
module DataWrapper

import Base.map, Base.reduce

export AbstractDataWrapper, data, unit, map


"
AbstractDataWrapper
-------------------
An abstract type for which some methods are defined
to aid adding functionality to types that wrap collections.
Primarily, this is accomplished by deriving methods for
map and reduce from methods for unit and data, where unit
is a constructor that puts data into the wrapping context, and
data is a method that pulls the underlying collection out of the 
wrapping context.
"
abstract AbstractDataWrapper

unit{ T <: AbstractDataWrapper }( ::Type{T} ) = x -> T( x )
data( x::AbstractDataWrapper ) = x.data

map{ T <: AbstractDataWrapper }( f, xs::T ... ) = unit( T )( map( f, map( data, xs ) ... ))
reduce{ T <: AbstractDataWrapper }( op, x::T ) = reduce( op, data( x ))


end # module

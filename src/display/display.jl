using Media, Lazy, Hiccup

import Media: render, @render
import Hiccup: div

import Juno: Inline, Clipboard, Editor, Console, PlotPane, Model, Tree, LazyTree,
             SubTree, Copyable, Link, Row, Table

Media.@defpool Editor
Media.@defpool Console

setdisplay(Editor(), Any, Console())
setdisplay(Console(), Any, Console())

render(::Clipboard, x) =
  sprint(io -> show(IOContext(io, limit=true), MIME"text/plain"(), x))

render(::Editor, x) =
  render(Inline(), Copyable(x))

render(::Console, x) =
  Atom.msg("result", render(Inline(), Copyable(x)))

render(::PlotPane, x) =
  Atom.msg("plot", render(Inline(), x))

@render Inline l::Row begin
  span([render(Inline(), x) for x in l.xs])
end

include("utils.jl")
include("base.jl")
include("plots.jl")
include("view.jl")
include("lazy.jl")
include("errors.jl")
include("frontend.jl")

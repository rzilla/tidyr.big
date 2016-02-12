expand_.tbl_HS2 =
  function(){
    is.nesting = function(expr) as.list(expr)[[1]] == "nesting"
    dots = lazyeval::as.lazy_dots(dots)
    stopif(length(dots) == 0, "nothing to expand")
    dots <- lazyeval::auto_name(dots)
    transdata = function(...) distinct(transmute(data, ...))
     map(
      seq_along(dots),
      function(i) {
        expr = dots[[i]]$expr
        dots[[i]]$expr <<-
          if(is.nesting(expr))
            expr
          else
            call("nesting", expr)})
    pieces <- lazyeval::lazy_eval(dots, list(nesting = transdata ))
    reduce(pieces, cross_join)}

formals(expand_.tbl_HS2) = formals(tidyr::expand_)

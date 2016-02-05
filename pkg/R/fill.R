fill_one =
  function(data, fill_col){
    tmp =
      select(
        ungroup(
          collapse(
            mutate_(
              group_by(
                collapse(
                  mutate_(
                    data,
                    gr_gtpncndwyv = interp(~cumsum(if(!is.na(fill_col)) 1 else 0), fill_col = as.name(fill_col)))),
                gr_gtpncndwyv),
            .dots = setNames(list(interp(~min(fill_col), fill_col =  as.name(fill_col))), fill_col)))),
        -gr_gtpncndwyv)
    if(is.null(groups(data)))
      tmp
    else
      group_by_(tmp, .dots = groups(data))}

fill_many =
  function(data, fill_cols){
    if(length(fill_cols) > 0)
      fill_many(fill_one(data, fill_cols[[1]]), fill_cols[-1])
    else
      data}

fill_.tbl_HS2 =
  function(){
    fill_many(
      arrange_(data, interp(~.direction, .direction = as.name(.direction))),
      fill_cols)}

formals(fill_.tbl_HS2) = formals(tidyr::fill_)

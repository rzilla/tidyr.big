#brickouse extension




brickhouse.extension =
  function(src) {
    add_extension(
      src,
      c(map_key_values  = "brickhouse.udf.collect.MapKeyValuesUDF",
        collect = "brickhouse.udf.collect.CollectUDAF"),
      Sys.getenv("BRICKHOUSE_JAR"))
    NULL}


# spark_dependencies <- function(spark_version, scala_version, ...) {
#   sparklyr::spark_dependency(
#     packages = c(
#       paste0("org.datasyslab:geospark-sql_",sparklyr::spark_dependency_fallback(spark_version, c("2.1", "2.2", "2.3")),":1.3.1"),
#       "com.vividsolutions:jts-core:1.14.0",
#       "org.datasyslab:geospark:1.3.1"
#     ),
#     initializer = function(sc, ...) {
#       register_gis(sc)
#     }
#   )
# }

spark_dependencies <- function(spark_version, scala_version, ...) {
  sparklyr::spark_dependency(
    jars = c(
      system.file(
        sprintf("java/sparkds-%s-%s.jar", spark_version, scala_version),
        package = "geospark"
      )
    ),
    packages = c(
      sprintf("com.databricks:spark-redshift_%s:0.6.0", scala_version),
      sprintf("com.databricks:spark-avro_%s:2.0.1", scala_version)
    )
  )
}

#' @import sparklyr dplyr
.onLoad <- function(libname, pkgname) {
  sparklyr::register_extension(pkgname)
}

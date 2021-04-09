## code to prepare `DATASET` dataset goes here

ids <- ons_ids()
ids_meta <- lapply(ids, ons_meta)

# Title
title <- Reduce(c, lapply(ids_meta, function(x) x$title))

# Size
size <- lapply(ids_meta, function(x) as.numeric(x$downloads$csv$size))
size_bt <- Reduce(c, lapply(size, function(x) utils:::format.object_size(x, "auto")))

dataset_size <- data.frame(Title = title, Id = ids, Size = size_bt)

usethis::use_data(dataset_size, overwrite = TRUE)

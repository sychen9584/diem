
# Test functions in debris_id.R

context("Debris calling")

library(Matrix)

nr <- 100
nc <- 100

test_thresh <- 95
pp_thresh <- 0.95
min_genes <- 98

set.seed(1)
counts <- sample(0:30, replace = TRUE, size = 1e4)
counts <- matrix(counts, nrow = nr, ncol = nc)
rownames(counts) <- paste0("G", as.character(1:nr))
colnames(counts) <- paste0("C", as.character(1:nc))

sce <- create_SCE(counts)
sce <- set_debris_test_set(sce, min_counts = 0, min_genes = test_thresh)
sce@test_data$CleanProb <- 0
clean <- rownames(sce@test_data)[sce@test_data$n_genes >= min_genes]
sce@test_data[clean, "CleanProb"] <- 1

sce <- filter_genes(sce, cpm_thresh = 0)
sce <- get_pcs(sce, n_var_genes = 50)
sce <- init(sce, k_init = 1)
sce <- get_dist(sce)
sce <- rm_close(sce)
sce <- run_em(sce)

ids <- rownames(sce@test_data)
names_pass <- ids[sce@test_data$CleanProb >= pp_thresh & sce@test_data$n_genes >= min_genes]
n_all <- length(names_pass)

test_that("Clean calling works",{
          sce_c <- call_targets(sce, pp_thresh = pp_thresh, min_genes = min_genes)
          expect_equal(sum(sce_c@test_data$Call == "Clean"), n_all)
          expect_equal(sort(get_clean_ids(sce_c)), sort(names_pass))
          nr1 <- get_removed_ids(sce_c, min_genes = 0)
          nr2 <- ids[sce_c@test_data$n_genes < min_genes & ids %in% sce_c@test_set]
          expect_equal(sort(nr1), sort(nr2))
          sce_c <- get_gene_pct(sce_c, "G1", name = "G")
          c1_g <- 100 * sce_c@counts["G1","C1"] / sum(sce_c@counts[,"C1"])
          expect_equal(sce_c@test_data["C1","G"], c1_g)

          sce_c <- call_targets(sce, pp_thresh = 1.1, min_genes = 0)
          expect_equal(sum(sce_c@test_data$Call == "Clean"), 0)
          expect_equal(length(get_clean_ids(sce_c)), 0)
          expect_error(get_gene_pct(sce_c, gene="doesntexist", "NAME"))
})

